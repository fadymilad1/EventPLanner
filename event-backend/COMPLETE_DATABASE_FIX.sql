-- Complete Database Fix
-- Run this in pgAdmin Query Tool to fix ALL issues

-- ============================================
-- STEP 1: Check what tables exist
-- ============================================
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('users', 'events', 'event_invitations', 'event_attendance')
ORDER BY table_name;

-- ============================================
-- STEP 2: Fix Events Table - Rename 'date' to 'event_date' if needed
-- ============================================
-- Check if column is named 'date' instead of 'event_date'
DO $$
BEGIN
    -- Rename 'date' column to 'event_date' if it exists
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'date'
    ) THEN
        ALTER TABLE events RENAME COLUMN date TO event_date;
        RAISE NOTICE 'Renamed column "date" to "event_date"';
    END IF;
    
    -- Rename 'time' column to 'event_time' if it exists
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'time'
    ) THEN
        ALTER TABLE events RENAME COLUMN time TO event_time;
        RAISE NOTICE 'Renamed column "time" to "event_time"';
    END IF;
END $$;

-- ============================================
-- STEP 3: Add missing columns to events table
-- ============================================
ALTER TABLE events ADD COLUMN IF NOT EXISTS title VARCHAR(255);
ALTER TABLE events ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE events ADD COLUMN IF NOT EXISTS event_date DATE;
ALTER TABLE events ADD COLUMN IF NOT EXISTS event_time TIME;
ALTER TABLE events ADD COLUMN IF NOT EXISTS location VARCHAR(255);
ALTER TABLE events ADD COLUMN IF NOT EXISTS organizer_id INTEGER;
ALTER TABLE events ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE events ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- ============================================
-- STEP 4: Create event_invitations table if missing
-- ============================================
CREATE TABLE IF NOT EXISTS event_invitations (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    inviter_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    invitee_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(20) NOT NULL DEFAULT 'attendee' CHECK (role IN ('organizer', 'attendee')),
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'declined')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(event_id, invitee_id)
);

-- Create indexes for event_invitations
CREATE INDEX IF NOT EXISTS idx_event_invitations_event_id ON event_invitations(event_id);
CREATE INDEX IF NOT EXISTS idx_event_invitations_invitee_id ON event_invitations(invitee_id);
CREATE INDEX IF NOT EXISTS idx_event_invitations_inviter_id ON event_invitations(inviter_id);

-- ============================================
-- STEP 5: Create event_attendance table if missing
-- ============================================
CREATE TABLE IF NOT EXISTS event_attendance (
    id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL REFERENCES events(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('going', 'maybe', 'not_going', 'pending')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(event_id, user_id)
);

-- Create indexes for event_attendance
CREATE INDEX IF NOT EXISTS idx_event_attendance_event_id ON event_attendance(event_id);
CREATE INDEX IF NOT EXISTS idx_event_attendance_user_id ON event_attendance(user_id);

-- ============================================
-- STEP 6: Add triggers for updated_at (if not exists)
-- ============================================
-- Create function if it doesn't exist
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers
DROP TRIGGER IF EXISTS update_events_updated_at ON events;
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_event_invitations_updated_at ON event_invitations;
CREATE TRIGGER update_event_invitations_updated_at BEFORE UPDATE ON event_invitations
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_event_attendance_updated_at ON event_attendance;
CREATE TRIGGER update_event_attendance_updated_at BEFORE UPDATE ON event_attendance
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ============================================
-- STEP 7: Add Primary Key and Foreign Keys if missing
-- ============================================
-- Primary key for events
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'events_pkey'
    ) THEN
        ALTER TABLE events ADD PRIMARY KEY (id);
    END IF;
END $$;

-- Foreign key for organizer_id
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'events_organizer_id_fkey'
    ) THEN
        ALTER TABLE events 
        ADD CONSTRAINT events_organizer_id_fkey 
        FOREIGN KEY (organizer_id) REFERENCES users(id) ON DELETE CASCADE;
    END IF;
END $$;

-- ============================================
-- STEP 8: Verify everything is correct
-- ============================================
-- Check events table structure
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

-- Check all tables exist
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('users', 'events', 'event_invitations', 'event_attendance')
ORDER BY table_name;

-- ============================================
-- Expected Result:
-- 
-- Tables: users, events, event_invitations, event_attendance
-- 
-- Events columns:
-- - id (integer, primary key)
-- - title (varchar(255))
-- - description (text)
-- - event_date (date)  <-- NOT 'date'
-- - event_time (time)  <-- NOT 'time'
-- - location (varchar(255))
-- - organizer_id (integer, foreign key)
-- - created_at (timestamp)
-- - updated_at (timestamp)
-- ============================================

