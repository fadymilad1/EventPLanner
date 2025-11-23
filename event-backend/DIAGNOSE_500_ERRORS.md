# Diagnosing 500 Internal Server Errors

## Quick Diagnosis Steps

### Step 1: Check Backend Server Console

**The backend server console will show the actual error!** Look for:
- `=== Get Organized Events Error ===`
- `=== Get Invited Events Error ===`
- `=== Create Event Error ===`

These will show the exact error code and message.

### Step 2: Run Diagnostic Script

```bash
cd event-backend
node test-event-queries.js
```

This will test:
- Database connection
- Table existence
- Query syntax
- Sample queries

### Step 3: Common Issues and Fixes

#### Issue 1: Database Tables Don't Exist

**Error Code:** `42P01`
**Error Message:** "relation 'events' does not exist"

**Fix:**
```bash
cd event-backend
psql -U postgres -d event_db -f setup.sql
```

#### Issue 2: Database Connection Failed

**Error Code:** `ECONNREFUSED` or `ENOTFOUND`

**Fix:**
1. Check if PostgreSQL is running
2. Verify `.env` file has correct credentials:
   ```env
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=event_db
   DB_USER=postgres
   DB_PASS=your_password
   ```

#### Issue 3: Database Doesn't Exist

**Error Code:** `3D000`

**Fix:**
```bash
psql -U postgres
CREATE DATABASE event_db;
\q
```

#### Issue 4: Authentication Failed

**Error Code:** `28P01`

**Fix:**
- Check PostgreSQL password in `.env` file
- Verify user has access to database

### Step 4: Check Server Logs

When you make a request, the server console should show:

```
=== Get Organized Events Error ===
Error code: 42P01
Error message: relation "events" does not exist
Error detail: ...
```

**Copy this error and it will tell you exactly what's wrong!**

## Most Likely Issue

Based on the 500 errors on all endpoints, the most likely issue is:

**Missing Database Tables**

### Quick Fix:

1. **Stop the backend server** (Ctrl+C)

2. **Run the setup script:**
   ```bash
   cd event-backend
   psql -U postgres -d event_db -f setup.sql
   ```

3. **Verify tables exist:**
   ```bash
   psql -U postgres -d event_db -c "\dt"
   ```
   
   You should see:
   - users
   - events
   - event_invitations
   - event_attendance

4. **Restart the server:**
   ```bash
   npm run dev
   ```

5. **Try again!**

## Still Having Issues?

1. **Check the backend console** - It now shows detailed error messages
2. **Run the diagnostic script:** `node test-event-queries.js`
3. **Check PostgreSQL is running**
4. **Verify .env file exists and is correct**

## Need More Help?

Share the error message from the backend console (not the frontend console). The backend console will show the exact error code and message that will help identify the issue.

