# Fixing Events Table in pgAdmin

## Problem
Error: `column "event_date" of relation "events" does not exist`

This means your `events` table exists but is missing required columns.

## Solution: Add Missing Columns

### Option 1: Run the Fix SQL Script (Recommended)

1. **Open pgAdmin**
2. **Connect to your database** (`event_db`)
3. **Open Query Tool** (Right-click on `event_db` → Query Tool)
4. **Open the fix script:**
   - File → Open → Select `fix-events-table.sql`
   - Or copy the contents from `fix-events-table.sql`
5. **Execute the script** (F5 or click Execute)

### Option 2: Check Current Structure First

1. **Open pgAdmin Query Tool**
2. **Run this to see what columns exist:**
   ```sql
   SELECT column_name, data_type, is_nullable 
   FROM information_schema.columns 
   WHERE table_name = 'events'
   ORDER BY ordinal_position;
   ```
3. **Compare with expected structure:**
   - `id` (SERIAL PRIMARY KEY)
   - `title` (VARCHAR(255) NOT NULL)
   - `description` (TEXT)
   - `event_date` (DATE NOT NULL)
   - `event_time` (TIME NOT NULL)
   - `location` (VARCHAR(255) NOT NULL)
   - `organizer_id` (INTEGER NOT NULL)
   - `created_at` (TIMESTAMP)
   - `updated_at` (TIMESTAMP)

### Option 3: Recreate the Table (If Safe)

**⚠️ WARNING: This will DELETE all existing events!**

Only do this if you don't have important data:

1. **Drop the existing table:**
   ```sql
   DROP TABLE IF EXISTS events CASCADE;
   ```

2. **Run the full setup.sql:**
   - File → Open → Select `setup.sql`
   - Execute it

### Option 4: Manual Column Addition

If you prefer to add columns one by one in pgAdmin:

1. **Right-click on `events` table** → Properties
2. **Go to Columns tab**
3. **Add missing columns:**
   - Click "Add Column"
   - Name: `event_date`, Type: `date`, Not Null: ✓
   - Name: `event_time`, Type: `time`, Not Null: ✓
   - Name: `description`, Type: `text`, Not Null: ✗
   - Name: `location`, Type: `varchar(255)`, Not Null: ✓
   - etc.

## Verify the Fix

After running the fix, verify the table structure:

```sql
SELECT column_name, data_type, is_nullable
FROM information_schema.columns 
WHERE table_name = 'events'
ORDER BY ordinal_position;
```

You should see all required columns.

## Test

1. **Restart your backend server** (if it's running)
2. **Try creating an event again**
3. **Check the backend console** - errors should be gone!

## Quick SQL Commands

If you just want to add the missing columns quickly, run these in pgAdmin Query Tool:

```sql
-- Add missing columns
ALTER TABLE events ADD COLUMN IF NOT EXISTS event_date DATE;
ALTER TABLE events ADD COLUMN IF NOT EXISTS event_time TIME;
ALTER TABLE events ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE events ADD COLUMN IF NOT EXISTS location VARCHAR(255);
ALTER TABLE events ADD COLUMN IF NOT EXISTS organizer_id INTEGER REFERENCES users(id);
ALTER TABLE events ADD COLUMN IF NOT EXISTS created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE events ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Make required columns NOT NULL (after adding data)
ALTER TABLE events ALTER COLUMN event_date SET NOT NULL;
ALTER TABLE events ALTER COLUMN event_time SET NOT NULL;
ALTER TABLE events ALTER COLUMN location SET NOT NULL;
ALTER TABLE events ALTER COLUMN organizer_id SET NOT NULL;
```

## Still Having Issues?

1. **Check if the table exists:**
   ```sql
   SELECT * FROM information_schema.tables WHERE table_name = 'events';
   ```

2. **Check all columns:**
   ```sql
   \d events
   ```
   (In psql command line, or use pgAdmin's table viewer)

3. **Share the output** and I can help further!

