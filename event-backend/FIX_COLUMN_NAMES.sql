-- Fix Column Names in Events Table
-- Run this FIRST in pgAdmin to rename columns

-- ============================================
-- STEP 1: Check current column names
-- ============================================
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

-- ============================================
-- STEP 2: Rename 'date' to 'event_date' if it exists
-- ============================================
DO $$
BEGIN
    -- Check if 'date' column exists and 'event_date' doesn't
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'date'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'event_date'
    ) THEN
        ALTER TABLE events RENAME COLUMN date TO event_date;
        RAISE NOTICE '✅ Renamed column "date" to "event_date"';
    ELSIF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'event_date'
    ) THEN
        RAISE NOTICE '✅ Column "event_date" already exists';
    ELSE
        RAISE NOTICE '⚠️ Column "date" does not exist';
    END IF;
END $$;

-- ============================================
-- STEP 3: Rename 'time' to 'event_time' if it exists
-- ============================================
DO $$
BEGIN
    -- Check if 'time' column exists and 'event_time' doesn't
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'time'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'event_time'
    ) THEN
        ALTER TABLE events RENAME COLUMN time TO event_time;
        RAISE NOTICE '✅ Renamed column "time" to "event_time"';
    ELSIF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'event_time'
    ) THEN
        RAISE NOTICE '✅ Column "event_time" already exists';
    ELSE
        RAISE NOTICE '⚠️ Column "time" does not exist';
    END IF;
END $$;

-- ============================================
-- STEP 4: Verify the column names are correct
-- ============================================
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

-- ============================================
-- Expected columns after fix:
-- - id
-- - title
-- - description
-- - event_date (NOT 'date')
-- - event_time (NOT 'time')
-- - location
-- - organizer_id
-- - created_at
-- - updated_at
-- ============================================

