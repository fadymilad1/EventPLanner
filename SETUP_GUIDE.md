# Complete Setup Guide - Event Planner Phase 0

This guide will walk you through the complete setup process step by step.

## Step 1: Install Prerequisites

### 1.1 Install Node.js
- Download from [https://nodejs.org/](https://nodejs.org/)
- Install the LTS version (v16 or higher)
- Verify installation:
  ```bash
  node --version
  npm --version
  ```

### 1.2 Install PostgreSQL
- Download from [https://www.postgresql.org/download/](https://www.postgresql.org/download/)
- Install PostgreSQL 12 or higher
- During installation, remember the password you set for the `postgres` user
- Verify installation:
  ```bash
  psql --version
  ```

### 1.3 Install Angular CLI (Optional but recommended)
```bash
npm install -g @angular/cli
```

Verify installation:
```bash
ng version
```

---

## Step 2: Set Up PostgreSQL Database

### 2.1 Open PostgreSQL Command Line

**Windows:**
- Open "SQL Shell (psql)" from Start Menu
- Press Enter for all defaults (localhost, postgres database, postgres user)
- Enter your PostgreSQL password

**Mac/Linux:**
```bash
psql -U postgres
```

### 2.2 Create Database
```sql
CREATE DATABASE event_db;
```

### 2.3 Connect to Database
```sql
\c event_db
```

### 2.4 Create Users Table
Copy and paste the SQL from `event-backend/setup.sql` or run:
```sql
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### 2.5 Exit psql
```sql
\q
```

---

## Step 3: Backend Setup

### 3.1 Navigate to Backend Directory
```bash
cd event-backend
```

### 3.2 Install Dependencies
```bash
npm install
```

### 3.3 Create .env File

Create a new file named `.env` in the `event-backend` directory with:
```env
PORT=5000
DB_USER=postgres
DB_PASS=your_postgres_password_here
DB_NAME=event_db
DB_HOST=localhost
DB_PORT=5432
JWT_SECRET=mysecretkey_change_this_in_production
```

**Important:** Replace `your_postgres_password_here` with the password you set during PostgreSQL installation.

### 3.4 Start Backend Server
```bash
npm run dev
```

You should see:
```
✅ Connected to PostgreSQL database
🚀 Server running on http://localhost:5000
📡 API endpoints available at http://localhost:5000/api/auth
```

Keep this terminal open!

---

## Step 4: Frontend Setup

### 4.1 Open a New Terminal

**Important:** Open a new terminal/command prompt window while the backend is still running.

### 4.2 Navigate to Frontend Directory
```bash
cd event-frontend
```

### 4.3 Install Dependencies
```bash
npm install
```

This may take a few minutes as it downloads Angular and all dependencies.

### 4.4 Start Frontend Development Server
```bash
npm start
```

Or if you have Angular CLI installed globally:
```bash
ng serve
```

You should see:
```
** Angular Live Development Server is listening on localhost:4200 **
```

Open your browser to: `http://localhost:4200`

---

## Step 5: Test the Application

### 5.1 Test Registration

1. You should see a "Register" form
2. Enter an email (e.g., `test@example.com`)
3. Enter a password (e.g., `password123`)
4. Confirm the password
5. Click "Register"

**Expected result:**
- Green success message: "Registration successful! You can now login."
- Form clears

### 5.2 Test Login

1. Click "Already have an account? Login" at the bottom
2. Enter the same email and password
3. Click "Login"

**Expected result:**
- Green success message: "Login successful! Welcome back."
- Check browser DevTools (F12) > Application > Local Storage
- You should see `token` and `user` entries

### 5.3 Test Error Cases

Try the following to test error handling:

1. **Duplicate registration:** Try registering the same email again
   - Should show: "User with this email already exists"

2. **Wrong password:** Login with wrong password
   - Should show: "Invalid email or password"

3. **Empty fields:** Try submitting empty forms
   - Should show: "Please fill in all fields"

---

## Step 6: Test with Postman (Optional)

### 6.1 Download Postman
- Visit [https://www.postman.com/downloads/](https://www.postman.com/downloads/)
- Install Postman

### 6.2 Test Register Endpoint

1. Create new request
2. Set method to `POST`
3. URL: `http://localhost:5000/api/auth/register`
4. Headers: `Content-Type: application/json`
5. Body (raw JSON):
   ```json
   {
     "email": "postman@test.com",
     "password": "test123"
   }
   ```
6. Click "Send"

**Expected response:**
```json
{
  "message": "User registered successfully",
  "user": {
    "id": 2,
    "email": "postman@test.com",
    "created_at": "2024-01-01T12:00:00.000Z"
  }
}
```

### 6.3 Test Login Endpoint

1. Create new request
2. Set method to `POST`
3. URL: `http://localhost:5000/api/auth/login`
4. Headers: `Content-Type: application/json`
5. Body (raw JSON):
   ```json
   {
     "email": "postman@test.com",
     "password": "test123"
   }
   ```
6. Click "Send"

**Expected response:**
```json
{
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 2,
    "email": "postman@test.com"
  }
}
```

For more detailed Postman testing, see [POSTMAN_COLLECTION.md](./POSTMAN_COLLECTION.md)

---

## Troubleshooting

### Backend Issues

**Problem:** `Error: Connection refused` or `password authentication failed`
**Solution:** 
- Check PostgreSQL is running
- Verify password in `.env` is correct
- Try connecting with: `psql -U postgres`

**Problem:** `relation "users" does not exist`
**Solution:** 
- Run the setup.sql file: `psql -U postgres -d event_db -f setup.sql`

**Problem:** Port 5000 already in use
**Solution:**
- Change PORT in `.env` to another port (e.g., 5001)
- Update frontend `auth.service.ts` to use new port

### Frontend Issues

**Problem:** `ng: command not found`
**Solution:**
- Install Angular CLI: `npm install -g @angular/cli`
- Or use: `npx ng serve` instead of `ng serve`

**Problem:** CORS errors in browser console
**Solution:**
- Verify backend is running
- Check backend `src/server.js` has CORS enabled
- Verify backend port matches frontend API URL

**Problem:** Can't connect to backend
**Solution:**
- Verify backend server is running
- Test backend directly: `http://localhost:5000`
- Check firewall settings

### General Issues

**Problem:** npm install fails
**Solution:**
- Delete `node_modules` folder
- Delete `package-lock.json`
- Run `npm install` again
- If still failing, try: `npm cache clean --force`

---

## What's Next?

Now that Phase 0 is complete, you have:
✅ User registration working
✅ User login with JWT authentication
✅ Secure password hashing
✅ Token-based authentication

You're ready to build Phase 1 with protected routes and event management!

---

## Need Help?

- Check the browser console for errors (F12)
- Check the backend terminal for error messages
- Verify all prerequisites are installed correctly
- Make sure both backend and frontend are running
