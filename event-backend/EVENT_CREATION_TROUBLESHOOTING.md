# Event Creation Error Troubleshooting Guide

## Recent Improvements Made

1. ✅ Enhanced error logging in event model
2. ✅ Added validation checks in controller
3. ✅ Fixed date validation comparison
4. ✅ Properly handle null/empty description field

## Common Causes and Solutions

### 1. **Database Connection Issues**

**Symptoms:**
- Error code: `ECONNREFUSED`, `ENOTFOUND`, `28P01`, or `3D000`
- Message: "Database connection failed" or "Database does not exist"

**Solution:**
```bash
# Check if PostgreSQL is running
# Windows: Check Services
# Linux/Mac: sudo systemctl status postgresql

# Verify .env file exists and has correct values
cd event-backend
cat .env  # or type .env on Windows

# Test database connection
npm run test-db
```

### 2. **Missing Database Tables**

**Symptoms:**
- Error code: `42P01`
- Message: "Database table does not exist"

**Solution:**
```bash
cd event-backend
psql -U postgres -d event_db -f setup.sql
```

### 3. **Validation Errors**

**Symptoms:**
- Status code: 400
- Message: "Validation failed"
- Errors array with specific field issues

**Common Issues:**
- **Date in the past**: Event date cannot be before today
- **Invalid date format**: Must be YYYY-MM-DD (e.g., 2024-12-25)
- **Invalid time format**: Must be HH:MM in 24-hour format (e.g., 14:30)
- **Title too short**: Must be at least 3 characters
- **Location too short**: Must be at least 3 characters

**Solution:**
- Check the error response for specific validation messages
- Ensure date is today or in the future
- Use correct date format: `YYYY-MM-DD`
- Use correct time format: `HH:MM` (24-hour)

### 4. **Missing Required Fields**

**Symptoms:**
- Error code: `23502`
- Message: "Required field is missing"

**Required Fields:**
- `title` (string, 3-255 characters)
- `event_date` (date, YYYY-MM-DD format)
- `event_time` (time, HH:MM format)
- `location` (string, 3-255 characters)
- `description` (optional)

**Solution:**
Ensure all required fields are provided in the request body.

### 5. **User Not Authenticated**

**Symptoms:**
- Status code: 401
- Message: "Authentication required. Please login first."

**Solution:**
- Make sure you're logged in
- Check that the JWT token is being sent in the Authorization header
- Token format: `Bearer <token>`

### 6. **Foreign Key Violation**

**Symptoms:**
- Error code: `23503`
- Message: "Invalid organizer. User not found."

**Solution:**
- This should not happen if authentication is working correctly
- The user ID from the JWT token should exist in the database
- Try logging out and logging back in

## Debugging Steps

### Step 1: Check Server Logs

When you try to create an event, check the server console. You should now see:
```
=== Create Event Error ===
Error code: ...
Error message: ...
Error detail: ...
Request body: ...
User: ...
```

This will tell you exactly what's wrong.

### Step 2: Test Database Connection

```bash
cd event-backend
npm run test-db
```

Expected output:
```
✅ Database connection successful!
✅ Users table exists
✅ Events table exists
```

### Step 3: Verify .env File

Make sure your `.env` file in `event-backend/` contains:
```env
DB_HOST=localhost
DB_PORT=5432
DB_NAME=event_db
DB_USER=postgres
DB_PASS=your_password
JWT_SECRET=your_secret_key
PORT=5000
NODE_ENV=development
```

### Step 4: Check Request Format

**Correct Request Format:**
```json
{
  "title": "Team Meeting",
  "description": "Weekly team sync",
  "event_date": "2024-12-25",
  "event_time": "14:30",
  "location": "Conference Room A"
}
```

**Important:**
- Date must be `YYYY-MM-DD` format
- Time must be `HH:MM` format (24-hour)
- Date must be today or in the future
- Title and location must be at least 3 characters

### Step 5: Check Authentication

Make sure:
1. You're logged in
2. The JWT token is valid
3. The Authorization header is set: `Authorization: Bearer <token>`

## Testing with Postman/Thunder Client

1. **Login first:**
   ```
   POST http://localhost:5000/api/auth/login
   Body: { "email": "your@email.com", "password": "yourpassword" }
   ```

2. **Copy the token from response**

3. **Create event:**
   ```
   POST http://localhost:5000/api/events
   Headers: Authorization: Bearer <your_token>
   Body: {
     "title": "Test Event",
     "event_date": "2024-12-25",
     "event_time": "14:30",
     "location": "Test Location"
   }
   ```

## Still Having Issues?

1. **Check the server console** - Detailed error logs are now printed
2. **Check the error response** - It now includes more specific information
3. **Verify database setup** - Run `setup.sql` again
4. **Restart the server** - Sometimes a restart helps
5. **Check PostgreSQL logs** - For database-specific issues

## Example Error Responses

### Validation Error:
```json
{
  "message": "Validation failed",
  "errors": [
    {
      "msg": "Event date cannot be in the past",
      "param": "event_date",
      "location": "body"
    }
  ]
}
```

### Database Error:
```json
{
  "message": "Database connection failed. Please check your database configuration.",
  "error": "connection refused",
  "code": "ECONNREFUSED"
}
```

### Missing Field:
```json
{
  "message": "Missing required fields. Title, date, time, and location are required.",
  "received": {
    "title": "Test",
    "event_date": null,
    "event_time": "14:30",
    "location": "Test"
  }
}
```

## Quick Fix Checklist

- [ ] PostgreSQL is running
- [ ] `.env` file exists and is correct
- [ ] Database `event_db` exists
- [ ] Tables are created (run `setup.sql`)
- [ ] Server is running (`npm run dev`)
- [ ] You're logged in
- [ ] Request format is correct
- [ ] Date is today or in the future
- [ ] Date format is YYYY-MM-DD
- [ ] Time format is HH:MM (24-hour)

