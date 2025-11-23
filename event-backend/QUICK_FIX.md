# Quick Fix for Registration Error

## Most Common Issue: Missing .env File or Database Setup

### Step 1: Check if .env file exists

```bash
cd event-backend
# Check if .env exists
```

If it doesn't exist, create it with this content:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=event_db
DB_USER=postgres
DB_PASS=fady
JWT_SECRET=your_super_secret_jwt_key_change_this
PORT=5000
NODE_ENV=development
```

**Replace `your_postgres_password` with your actual PostgreSQL password.**

### Step 2: Create the database (if it doesn't exist)

```bash
# Connect to PostgreSQL
psql -U postgres

# Create the database
CREATE DATABASE event_db;

# Exit
\q
```

### Step 3: Run the setup script to create tables

```bash
cd event-backend
psql -U postgres -d event_db -f setup.sql
```

### Step 4: Test the database connection

```bash
npm run test-db
```

You should see:
```
✅ Database connection successful!
✅ Users table exists
✅ Events table exists
```

### Step 5: Restart the server

```bash
npm run dev
```

### Step 6: Try registering again

The error message should now be more specific and tell you exactly what's wrong.

## If You Still Get Errors

1. **Check the server console** - it will now show detailed error messages
2. **Check the browser console** - the error response will be more descriptive
3. **Run the test script**: `npm run test-db` to see what's wrong

## Common Issues:

1. **PostgreSQL not running** - Start PostgreSQL service
2. **Wrong password** - Check your .env file
3. **Database doesn't exist** - Create it (see Step 2)
4. **Tables don't exist** - Run setup.sql (see Step 3)
5. **Port 5000 already in use** - Change PORT in .env or stop the other process

