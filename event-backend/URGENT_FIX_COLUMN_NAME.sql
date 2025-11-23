-- URGENT FIX: Rename 'date' column to 'event_date'
-- Run this in pgAdmin Query Tool RIGHT NOW

-- Step 1: Check what columns exist
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

-- Step 2: Rename 'date' to 'event_date' (safe - only if 'date' exists and 'event_date' doesn't)
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'date'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'event_date'
    ) THEN
        ALTER TABLE events RENAME COLUMN date TO event_date;
        RAISE NOTICE '✅ Renamed "date" to "event_date"';
    ELSE
        RAISE NOTICE 'ℹ️ Column "date" does not exist or "event_date" already exists';
    END IF;
END $$;

-- Step 3: Rename 'time' to 'event_time' (safe - only if 'time' exists and 'event_time' doesn't)
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'time'
    ) AND NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'events' AND column_name = 'event_time'
    ) THEN
        ALTER TABLE events RENAME COLUMN time TO event_time;
        RAISE NOTICE '✅ Renamed "time" to "event_time"';
    ELSE
        RAISE NOTICE 'ℹ️ Column "time" does not exist or "event_time" already exists';
    END IF;
END $$;

-- Step 4: Verify the fix
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;

-- After running this, restart your backend server and try creating an event again!

