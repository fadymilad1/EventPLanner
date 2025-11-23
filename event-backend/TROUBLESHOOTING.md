# Troubleshooting Guide - Registration Error

## Common Issues and Solutions

### 1. "Server error during registration"

This error can occur for several reasons. Follow these steps to diagnose:

#### Step 1: Check Environment Variables

Make sure you have a `.env` file in the `event-backend` directory with the following variables:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=event_db
DB_USER=postgres
DB_PASS=your_password_here
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
PORT=5000
NODE_ENV=development
```

**To check if .env file exists:**
```bash
cd event-backend
ls -la .env
# or on Windows:
dir .env
```

**If .env doesn't exist:**
1. Create a new file named `.env` in the `event-backend` directory
2. Copy the content from `.env.example` (if it exists) or use the template above
3. Update the values with your actual database credentials

#### Step 2: Test Database Connection

Run the database test script:

```bash
cd event-backend
npm run test-db
```

This will check:
- Database connection
- If the `users` table exists
- If the `events` table exists

**Expected output if everything is working:**
```
✅ Database connection successful!
✅ Users table exists
✅ Events table exists
```

**If you get connection errors:**
- Make sure PostgreSQL is running
- Check your database credentials in `.env`
- Verify the database exists

#### Step 3: Check if Database Tables Exist

Connect to your PostgreSQL database and check if tables exist:

```bash
psql -U postgres -d event_db
```

Then run:
```sql
\dt
```

You should see:
- users
- events
- event_invitations
- event_attendance

**If tables don't exist:**
Run the setup script:
```bash
psql -U postgres -d event_db -f setup.sql
```

Or manually execute the SQL commands from `setup.sql`.

#### Step 4: Check Server Logs

When you start the server, check the console output:

```bash
cd event-backend
npm run dev
```

**Look for:**
- ✅ Database connection messages
- ❌ Error messages about missing environment variables
- ❌ Database connection errors

#### Step 5: Check Backend Server is Running

Make sure the backend server is running on port 5000:

```bash
# Check if server is running
curl http://localhost:5000
```

You should see:
```json
{"message":"Event Planner API - Phase 1"}
```

### 2. Common Error Codes and Solutions

#### Error Code: `ECONNREFUSED`
**Problem:** Cannot connect to PostgreSQL
**Solution:**
- Make sure PostgreSQL is running
- Check if the host and port are correct in `.env`
- On Windows: Check if PostgreSQL service is running in Services

#### Error Code: `28P01`
**Problem:** Authentication failed
**Solution:**
- Check your database username and password in `.env`
- Make sure the user has permissions to access the database

#### Error Code: `3D000`
**Problem:** Database doesn't exist
**Solution:**
```sql
CREATE DATABASE event_db;
```

#### Error Code: `42P01`
**Problem:** Table doesn't exist
**Solution:**
```bash
psql -U postgres -d event_db -f setup.sql
```

#### Error Code: `23505`
**Problem:** Duplicate email (user already exists)
**Solution:**
- This is not an error - the user already exists
- Try logging in instead of registering
- Or use a different email

### 3. Quick Fix Checklist

- [ ] PostgreSQL is installed and running
- [ ] `.env` file exists in `event-backend` directory
- [ ] All environment variables are set in `.env`
- [ ] Database `event_db` exists
- [ ] Database tables are created (run `setup.sql`)
- [ ] Backend server is running on port 5000
- [ ] No firewall blocking port 5000
- [ ] Database credentials are correct

### 4. Step-by-Step Setup

If you're starting fresh, follow these steps:

1. **Install PostgreSQL** (if not already installed)
   - Download from: https://www.postgresql.org/download/
   - Remember the password you set for the `postgres` user

2. **Create the database**
   ```sql
   CREATE DATABASE event_db;
   ```

3. **Create .env file**
   ```bash
   cd event-backend
   # Create .env file with your database credentials
   ```

4. **Run setup script**
   ```bash
   psql -U postgres -d event_db -f setup.sql
   ```

5. **Test database connection**
   ```bash
   npm run test-db
   ```

6. **Start the server**
   ```bash
   npm run dev
   ```

7. **Test registration**
   - Open http://localhost:4200
   - Try to register a new user
   - Check the server console for any errors

### 5. Getting More Detailed Error Messages

The improved error handling will now show more specific error messages. Check:

1. **Browser Console** (F12 → Console tab)
   - Look for the error response from the API
   - The error message should be more descriptive now

2. **Server Console**
   - Check the terminal where the backend server is running
   - Look for error logs with error codes

3. **Network Tab** (F12 → Network tab)
   - Find the registration request
   - Check the response for error details

### 6. Still Having Issues?

If you're still experiencing issues after following these steps:

1. **Check the exact error message** in the browser console or server logs
2. **Verify your PostgreSQL version** (should be 12 or higher)
3. **Check if port 5000 is available** (another process might be using it)
4. **Try restarting PostgreSQL service**
5. **Check file permissions** for the `.env` file

### 7. Test the Registration Endpoint Directly

You can test the registration endpoint using curl:

```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

This will help you see the exact error message from the server.

## Need More Help?

If you're still stuck, provide the following information:
1. The exact error message from the browser console
2. The error message from the server console
3. The output of `npm run test-db`
4. Your PostgreSQL version
5. Your Node.js version

