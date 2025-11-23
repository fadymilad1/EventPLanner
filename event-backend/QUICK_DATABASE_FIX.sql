-- Quick Fix for Missing Columns in Events Table
-- Run this in pgAdmin Query Tool
-- This script is safe to run multiple times - it won't break if columns already exist

-- ============================================
-- STEP 1: Check current columns (see what exists)
-- ============================================
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

-- ============================================
-- STEP 2: Add missing columns (safe - won't duplicate)
-- ============================================
-- Note: Don't add 'id' if it already exists as SERIAL - it will cause errors
-- Only add these columns if they don't exist
ALTER TABLE events ADD COLUMN IF NOT EXISTS title VARCHAR(255);
ALTER TABLE events ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE events ADD COLUMN IF NOT EXISTS event_date DATE;
ALTER TABLE events ADD COLUMN IF NOT EXISTS event_time TIME;
ALTER TABLE events ADD COLUMN IF NOT EXISTS location VARCHAR(255);
ALTER TABLE events ADD COLUMN IF NOT EXISTS organizer_id INTEGER;
ALTER TABLE events ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE events ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- ============================================
-- STEP 3: Add Primary Key if missing
-- ============================================
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'events_pkey'
    ) THEN
        ALTER TABLE events ADD PRIMARY KEY (id);
    END IF;
END $$;

-- ============================================
-- STEP 4: Add Foreign Key constraint if missing
-- ============================================
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
-- STEP 5: Set default values for new columns (if table has existing rows)
-- ============================================
-- Update any NULL values in existing rows
UPDATE events 
SET event_date = CURRENT_DATE 
WHERE event_date IS NULL;

UPDATE events 
SET event_time = '12:00:00' 
WHERE event_time IS NULL;

UPDATE events 
SET location = 'TBD' 
WHERE location IS NULL OR location = '';

UPDATE events 
SET title = 'Untitled Event' 
WHERE title IS NULL OR title = '';

-- ============================================
-- STEP 6: Make required columns NOT NULL (only if you're sure)
-- ============================================
-- Uncomment these lines ONLY if:
-- 1. The table is empty, OR
-- 2. You've updated all existing rows (see STEP 5 above)

-- ALTER TABLE events ALTER COLUMN title SET NOT NULL;
-- ALTER TABLE events ALTER COLUMN event_date SET NOT NULL;
-- ALTER TABLE events ALTER COLUMN event_time SET NOT NULL;
-- ALTER TABLE events ALTER COLUMN location SET NOT NULL;
-- ALTER TABLE events ALTER COLUMN organizer_id SET NOT NULL;

-- ============================================
-- STEP 7: Verify columns exist and are correct
-- ============================================
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

-- ============================================
-- Expected Result:
-- id (integer, not null, primary key)
-- title (varchar(255), nullable)
-- description (text, nullable)
-- event_date (date, nullable)
-- event_time (time, nullable)
-- location (varchar(255), nullable)
-- organizer_id (integer, nullable, foreign key to users.id)
-- created_at (timestamp, nullable, default CURRENT_TIMESTAMP)
-- updated_at (timestamp, nullable, default CURRENT_TIMESTAMP)
-- ============================================

