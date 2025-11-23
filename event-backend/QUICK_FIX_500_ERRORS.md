# Quick Fix for 500 Internal Server Errors

## ⚠️ Most Common Issue: Missing Database Tables

If you're getting 500 errors on ALL endpoints (`/api/events/organized`, `/api/events/invited`, `/api/events`), the most likely cause is **missing database tables**.

## 🔧 Quick Fix (3 Steps)

### Step 1: Stop the Backend Server
Press `Ctrl+C` in the terminal where the backend server is running.

### Step 2: Create Database Tables
```bash
cd event-backend
psql -U postgres -d event_db -f setup.sql
```

**If you get an error, try:**
```bash
# Windows (if psql is not in PATH)
"C:\Program Files\PostgreSQL\15\bin\psql.exe" -U postgres -d event_db -f setup.sql

# Or use pgAdmin to run setup.sql
```

### Step 3: Restart the Server
```bash
npm run dev
```

## ✅ Verify It Worked

After restarting, check the backend console. You should see:
```
✅ Connected to PostgreSQL database
🚀 Server running on http://localhost:5000
```

Then try creating an event again in the frontend.

## 🔍 If It Still Doesn't Work

### Check Backend Console for Error Details

The backend console will now show detailed error messages like:
```
=== Get Organized Events Error ===
Error code: 42P01
Error message: relation "events" does not exist
```

**Share this error message** - it will tell us exactly what's wrong!

### Run Diagnostic Script

```bash
cd event-backend
npm run test-queries
```

This will test:
- Database connection
- Table existence  
- Query syntax

### Common Error Codes

| Error Code | Meaning | Fix |
|------------|---------|-----|
| `42P01` | Table doesn't exist | Run `setup.sql` |
| `ECONNREFUSED` | Can't connect to database | Check PostgreSQL is running |
| `28P01` | Wrong password | Check `.env` file |
| `3D000` | Database doesn't exist | Create database first |

## 📋 Checklist

Before trying again, make sure:
- [ ] PostgreSQL is running
- [ ] `.env` file exists in `event-backend/` folder
- [ ] Database `event_db` exists
- [ ] Tables are created (run `setup.sql`)
- [ ] Backend server is running (`npm run dev`)
- [ ] You're logged in (have a valid JWT token)

## 🆘 Still Stuck?

1. **Check the backend console** - It shows the exact error
2. **Run diagnostic:** `npm run test-queries`
3. **Share the error message** from backend console (not frontend)

The backend console error message will tell us exactly what's wrong!

