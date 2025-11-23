-- Fix Events Table Structure
-- Run this in pgAdmin if your events table is missing columns

-- First, check what columns exist (run this to see current structure):
-- SELECT column_name, data_type, is_nullable 
-- FROM information_schema.columns 
-- WHERE table_name = 'events';

-- If event_date column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS event_date DATE NOT NULL DEFAULT CURRENT_DATE;

-- If event_time column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS event_time TIME NOT NULL DEFAULT '12:00:00';

-- If description column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS description TEXT;

-- If location column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS location VARCHAR(255) NOT NULL DEFAULT 'TBD';

-- If organizer_id column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS organizer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE;

-- If created_at column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- If updated_at column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- If title column doesn't exist, add it:
ALTER TABLE events 
ADD COLUMN IF NOT EXISTS title VARCHAR(255) NOT NULL DEFAULT 'Untitled Event';

-- After adding columns, you may need to update existing rows
-- Remove the DEFAULT values if you want to enforce NOT NULL properly
-- (Only run these if you have existing data that needs updating)

-- Update any NULL values (if you have existing rows):
-- UPDATE events SET event_date = CURRENT_DATE WHERE event_date IS NULL;
-- UPDATE events SET event_time = '12:00:00' WHERE event_time IS NULL;
-- UPDATE events SET location = 'TBD' WHERE location IS NULL;

-- Verify the table structure:
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

