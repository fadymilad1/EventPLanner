# Setting Up Database in pgAdmin

This guide will help you set up the Event Planner database using pgAdmin.

## Step 1: Connect to PostgreSQL Server in pgAdmin

1. Open **pgAdmin**
2. In the left panel, expand **Servers**
3. If you don't have a server connection:
   - Right-click **Servers** → **Create** → **Server**
   - **General Tab:**
     - Name: `PostgreSQL` (or any name you prefer)
   - **Connection Tab:**
     - Host name/address: `localhost`
     - Port: `5432`
     - Maintenance database: `postgres`
     - Username: `postgres`
     - Password: `fady`
   - Click **Save**

## Step 2: Create the Database

1. Expand your server connection
2. Right-click on **Databases** → **Create** → **Database**
3. **General Tab:**
   - Database name: `event_db`
4. Click **Save**

## Step 3: Run the Setup SQL Script

1. Expand **Databases** → **event_db**
2. Right-click on **event_db** → **Query Tool**
3. Open the `setup.sql` file from the `event-backend` folder
4. Copy the entire contents of `setup.sql`
5. Paste it into the Query Tool
6. Click the **Execute** button (or press F5)

You should see messages like:
- `CREATE TABLE`
- `CREATE INDEX`
- `CREATE FUNCTION`
- `CREATE TRIGGER`

## Step 4: Verify Tables Were Created

1. In pgAdmin, expand **event_db** → **Schemas** → **public** → **Tables**
2. You should see these tables:
   - ✅ `users`
   - ✅ `events`
   - ✅ `event_invitations`
   - ✅ `event_attendance`

## Step 5: Create/Update .env File

1. In the `event-backend` folder, create a file named `.env` (if it doesn't exist)
2. Add the following content:

```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=event_db
DB_USER=postgres
DB_PASS=your_postgres_password_here
JWT_SECRET=your_super_secret_jwt_key_change_this_in_production
PORT=5000
NODE_ENV=development
```

**Important:** Replace `your_postgres_password_here` with your actual PostgreSQL password (the one you use to connect in pgAdmin).

## Step 6: Test the Database Connection

1. Open a terminal in the `event-backend` folder
2. Run:
   ```bash
   npm run test-db
   ```

You should see:
```
✅ Database connection successful!
✅ Users table exists
✅ Events table exists
```

## Step 7: Start the Backend Server

```bash
cd event-backend
npm run dev
```

You should see:
```
🚀 Server running on http://localhost:5000
📡 API endpoints available at http://localhost:5000/api/auth
```

## Troubleshooting

### If you get "Database does not exist" error:
- Make sure you created the database `event_db` in pgAdmin
- Check the database name in your `.env` file matches

### If you get "Authentication failed" error:
- Check your PostgreSQL password in the `.env` file
- Make sure it matches the password you use in pgAdmin

### If you get "Table does not exist" error:
- Make sure you ran the `setup.sql` script in the Query Tool
- Verify the tables exist in pgAdmin under `event_db` → `Schemas` → `public` → `Tables`

### If you can't connect to PostgreSQL:
- Make sure PostgreSQL service is running
- On Windows: Check Services (services.msc) and make sure PostgreSQL is running
- Verify the port (default is 5432)

## Quick Reference

**Database Name:** `event_db`  
**Default Port:** `5432`  
**Default User:** `postgres`  
**Tables Created:**
- `users` - User accounts
- `events` - Event information
- `event_invitations` - Event invitations
- `event_attendance` - Attendance tracking

## Next Steps

After setting up the database:
1. ✅ Database created in pgAdmin
2. ✅ Tables created (ran setup.sql)
3. ✅ .env file configured
4. ✅ Database connection tested
5. ✅ Backend server running

Now you can test registration at `http://localhost:4200/register`!

