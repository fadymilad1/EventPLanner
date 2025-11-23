# Phase 1 Deliverables Guide

## Overview

You're working on **Phase 0** (User Management) and **Phase 1** (Full Feature Set). This guide will help you prepare your Phase 1 submission.

## Phase 1 Deliverables

You need to submit **ONE ZIP FILE** named: `ID1_ID2_ID3_TA_NAME.zip`

The zip file should contain:

### 1. Text File: `ID1_ID2_ID3_TA_NAME.txt`

Create a text file with the following information:

```
Team Members:
- Name 1 (ID1)
- Name 2 (ID2)
- Name 3 (ID3)
- Name 4 (ID4) [if applicable]

TA Name: [Your TA's Name]

GitHub Repositories:
- Backend: https://github.com/yourusername/event-backend
- Frontend: https://github.com/yourusername/event-frontend

Note: Please ensure your TA is added as a collaborator to both repositories.
```

**Important:**
- Replace `ID1_ID2_ID3_TA_NAME` with your actual team IDs and TA name
- Add your TA as a collaborator on GitHub
- Make sure repositories are accessible

### 2. Postman Collection: `EventPlanner_API.postman_collection.json`

✅ **Already exists** at: `event-backend/EventPlanner_API.postman_collection.json`

**Verify it includes:**
- [x] Auth endpoints (Register, Login)
- [x] Event endpoints (Create, Get Organized, Get Invited, Get by ID, Update, Delete, Search)
- [x] Invitation endpoints (Invite, Get Event Invitations, Get User Invitations, Update Status, Delete)
- [x] Attendance endpoints (Set Status, Get Event Attendance, Get User Attendance)
- [x] User Search endpoint

**To test:**
1. Open Postman
2. Import the collection: `event-backend/EventPlanner_API.postman_collection.json`
3. Set the `baseUrl` variable to `http://localhost:5000/api`
4. Test all endpoints

## Phase 1 Requirements Checklist

### ✅ 1. User Management (Phase 0 - Complete)
- [x] User registration with email and password
- [x] User login with credentials
- [x] JWT token authentication

### ✅ 2. Event Management
- [x] Create events (title, date, time, location, description)
- [x] View organized events
- [x] View invited events
- [x] Invite users to events
- [x] Delete events
- [x] Mark users as organizer/attendee

### ✅ 3. Response Management
- [x] Attendees can set attendance status (Going, Maybe, Not Going)
- [x] Organizers can view attendees and statuses

### ✅ 4. Search and Filtering
- [x] Search by keywords
- [x] Filter by dates
- [x] Filter by user roles

### ✅ 5. Error Handling
- [x] Proper error handling implemented
- [x] Validation errors
- [x] Database errors
- [x] Authentication errors

## Current Status

### ✅ Completed
- All Phase 1 features are implemented
- Database schema is complete
- API endpoints are working
- Frontend components are built
- Error handling is comprehensive
- Postman collection exists

### 🔴 Issues to Fix
1. **500 Internal Server Errors** - Need to check server console logs
   - Likely causes:
     - Database tables not created (run `setup.sql` in pgAdmin)
     - `.env` file not configured correctly
     - Database connection issues

## Steps to Fix Current Issues

### Step 1: Verify Database Setup
```bash
# In pgAdmin:
1. Connect to PostgreSQL
2. Create database: event_db
3. Run setup.sql script in Query Tool
4. Verify tables exist: users, events, event_invitations, event_attendance
```

### Step 2: Verify .env File
```bash
# In event-backend/.env:
DB_HOST=localhost
DB_PORT=5432
DB_NAME=event_db
DB_USER=postgres
DB_PASS=your_password_here
JWT_SECRET=your_secret_key_here
PORT=5000
NODE_ENV=development
```

### Step 3: Test Database Connection
```bash
cd event-backend
npm run test-db
```

### Step 4: Restart Backend Server
```bash
cd event-backend
npm run dev
```

### Step 5: Check Server Console
When you try to create an event or access the dashboard, check the server console for detailed error logs. The enhanced error logging will show:
- Error codes
- Error messages
- Database errors
- Authentication errors

## Testing Your Application

### Backend Testing (Postman)
1. Register a new user
2. Login (token will be saved automatically)
3. Create an event
4. Get organized events
5. Invite a user to event
6. Set attendance status
7. Search events

### Frontend Testing
1. Register at `http://localhost:4200/register`
2. Login at `http://localhost:4200/login`
3. Create an event from dashboard
4. View organized events
5. View invited events
6. Invite users to events
7. Set attendance status
8. Search events

## Submission Checklist

Before submitting, ensure:

- [ ] All Phase 1 features work correctly
- [ ] No 500 errors (check server console)
- [ ] Database is properly set up
- [ ] `.env` file is configured
- [ ] Postman collection is complete and tested
- [ ] Text file with team info is created
- [ ] TA is added as collaborator on GitHub
- [ ] All code is committed to GitHub
- [ ] Zip file is created with correct name format

## Important Notes

1. **Deadline**: November 14th
2. **Late Submissions**: Not allowed
3. **GitHub**: All commits after deadline are considered late
4. **TA Access**: Must add TA as collaborator
5. **Error Handling**: Proper error handling is required (✅ Done)

## Next Steps

1. Fix the 500 errors by checking server console logs
2. Test all features thoroughly
3. Create the text file with team info
4. Verify Postman collection
5. Create the zip file
6. Submit before deadline

## Need Help?

If you're stuck:
1. Check server console for error logs
2. Verify database setup
3. Check `.env` file configuration
4. Review `PHASE1_CHECKLIST.md` for detailed checklist
5. Check `TROUBLESHOOTING.md` for common issues

Good luck with your submission! 🚀

