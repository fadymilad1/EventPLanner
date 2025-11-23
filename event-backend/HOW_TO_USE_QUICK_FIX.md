# How to Use QUICK_DATABASE_FIX.sql

## Quick Steps:

1. **Open pgAdmin**
2. **Connect to your PostgreSQL server**
3. **Navigate to:** Databases → `event_db`
4. **Right-click on `event_db`** → **Query Tool**
5. **Open the file:** File → Open → Select `QUICK_DATABASE_FIX.sql`
6. **Execute the script:** Press F5 or click the Execute button (▶)

## What the Script Does:

### Step 1: Shows Current Columns
- Displays what columns currently exist in the `events` table
- Helps you see what's missing

### Step 2: Adds Missing Columns
- Safely adds any missing columns
- Uses `IF NOT EXISTS` so it won't break if columns already exist
- Adds: title, description, event_date, event_time, location, organizer_id, created_at, updated_at

### Step 3: Adds Primary Key
- Ensures the `id` column has a primary key constraint

### Step 4: Adds Foreign Key
- Ensures `organizer_id` references `users(id)`

### Step 5: Updates Existing Data
- If you have existing rows with NULL values, this sets defaults
- Safe to run - only updates NULL values

### Step 6: Makes Columns NOT NULL (Optional)
- **IMPORTANT:** These are commented out by default
- Only uncomment if:
  - Your table is empty, OR
  - You've verified all existing rows have values (Step 5 ran successfully)

### Step 7: Verifies Results
- Shows the final table structure
- Compare with the "Expected Result" section

## After Running:

1. **Check the results** - Step 7 should show all columns
2. **Restart your backend server** (if running)
3. **Try creating an event again**

## Troubleshooting:

### Error: "column already exists"
- This is OK! The script uses `IF NOT EXISTS` so it won't add duplicates
- Just continue - the script will skip existing columns

### Error: "cannot add NOT NULL constraint"
- This means you have NULL values in existing rows
- Run Step 5 first to update NULL values
- Then uncomment Step 6

### Error: "relation 'events' does not exist"
- The table doesn't exist at all
- Run `setup.sql` first to create the table
- Then run this script to add any missing columns

## Expected Output:

After running, you should see:
- All 9 columns listed in Step 7
- No errors (or only "already exists" messages which are OK)
- The table structure matches the "Expected Result" section

## Still Having Issues?

1. **Check the backend console** for specific error messages
2. **Share the error** from Step 7 output
3. **Check if the table exists:** `SELECT * FROM events LIMIT 1;`

