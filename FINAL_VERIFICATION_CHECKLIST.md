# Final Verification Checklist - Phase 1

## ✅ Setup Verification

### Database
- [x] ✅ Database connection successful
- [x] ✅ Users table exists
- [x] ✅ Events table exists
- [ ] ⚠️ Verify all tables exist: `event_invitations`, `event_attendance`
- [x] ✅ .env file exists and configured

### Backend
- [ ] ⚠️ Backend server running on port 5000
- [ ] ⚠️ No errors in server console
- [ ] ⚠️ All routes registered correctly
- [x] ✅ CORS configured
- [x] ✅ Error handling implemented

### Frontend
- [ ] ⚠️ Frontend running on port 4200
- [ ] ⚠️ No errors in browser console
- [ ] ⚠️ All components loading correctly

## 🧪 Feature Testing Checklist

### 1. User Management (Phase 0)
- [ ] **Register User**
  - [ ] Go to `/register`
  - [ ] Fill in email and password
  - [ ] Submit form
  - [ ] ✅ Should redirect to login
  - [ ] ✅ Should see success message

- [ ] **Login User**
  - [ ] Go to `/login`
  - [ ] Enter registered credentials
  - [ ] Submit form
  - [ ] ✅ Should redirect to dashboard
  - [ ] ✅ Token stored in localStorage
  - [ ] ✅ User data stored in localStorage

- [ ] **Test Invalid Login**
  - [ ] Try wrong password
  - [ ] ✅ Should show error message
  - [ ] Try non-existent email
  - [ ] ✅ Should show error message

### 2. Event Management

- [ ] **Create Event**
  - [ ] Login first
  - [ ] Go to create event page
  - [ ] Fill in: Title, Date, Time, Location, Description
  - [ ] Submit form
  - [ ] ✅ Should create event successfully
  - [ ] ✅ Should redirect to dashboard
  - [ ] ✅ Event appears in "My Events" tab

- [ ] **View Organized Events**
  - [ ] Go to dashboard
  - [ ] Click "My Events" tab
  - [ ] ✅ Should see all events you created
  - [ ] ✅ Events display correctly (title, date, time, location)

- [ ] **View Invited Events**
  - [ ] Go to dashboard
  - [ ] Click "Invited Events" tab
  - [ ] ✅ Should see events you're invited to (if any)
  - [ ] ✅ Shows invitation status

- [ ] **View Event Details**
  - [ ] Click on an event
  - [ ] ✅ Should show full event details
  - [ ] ✅ Should show invitations list
  - [ ] ✅ Should show attendance list (if organizer)

- [ ] **Edit Event**
  - [ ] Click "Edit" on an event you created
  - [ ] Modify event details
  - [ ] Save changes
  - [ ] ✅ Should update successfully
  - [ ] ✅ Changes reflected in dashboard

- [ ] **Delete Event**
  - [ ] Click "Delete" on an event you created
  - [ ] Confirm deletion
  - [ ] ✅ Should delete successfully
  - [ ] ✅ Event removed from dashboard

### 3. Invitation Management

- [ ] **Invite User to Event**
  - [ ] Go to event details page
  - [ ] Search for a user by email
  - [ ] Select user from results
  - [ ] Choose role (organizer/attendee)
  - [ ] Send invitation
  - [ ] ✅ Should send invitation successfully
  - [ ] ✅ User appears in invitations list

- [ ] **View Event Invitations**
  - [ ] Go to event details page
  - [ ] ✅ Should see all invitations for that event
  - [ ] ✅ Shows invitee email and status

- [ ] **View My Invitations**
  - [ ] Login as invited user
  - [ ] Go to dashboard
  - [ ] ✅ Should see invitations in "Invited Events" tab
  - [ ] ✅ Shows invitation status (pending/accepted/declined)

- [ ] **Accept/Decline Invitation**
  - [ ] As invited user, view invitation
  - [ ] Accept or decline invitation
  - [ ] ✅ Status should update
  - [ ] ✅ Event appears/disappears from invited events

### 4. Attendance Management

- [ ] **Set Attendance Status**
  - [ ] Go to event details page (as attendee)
  - [ ] Set attendance: Going, Maybe, or Not Going
  - [ ] ✅ Should save successfully
  - [ ] ✅ Status displayed correctly

- [ ] **View Event Attendance (Organizer)**
  - [ ] As event organizer, go to event details
  - [ ] ✅ Should see attendance list
  - [ ] ✅ Shows all attendees and their statuses
  - [ ] ✅ Shows attendance statistics

- [ ] **View My Attendance**
  - [ ] Go to event details page
  - [ ] ✅ Should see your attendance status
  - [ ] ✅ Can change status

### 5. Search and Filtering

- [ ] **Search by Keyword**
  - [ ] Go to search page
  - [ ] Enter keyword in search box
  - [ ] Submit search
  - [ ] ✅ Should show matching events
  - [ ] ✅ Searches in title and description

- [ ] **Filter by Date Range**
  - [ ] Go to search page
  - [ ] Enter start date and end date
  - [ ] Submit search
  - [ ] ✅ Should show events within date range

- [ ] **Filter by Role**
  - [ ] Go to search page
  - [ ] Select role filter (organizer/attendee)
  - [ ] Submit search
  - [ ] ✅ Should show events based on role
  - [ ] ✅ "Organizer" shows events you created
  - [ ] ✅ "Attendee" shows events you're invited to

- [ ] **Combined Filters**
  - [ ] Use keyword + date + role filters together
  - [ ] ✅ Should apply all filters correctly

## 🔍 Error Handling Verification

- [ ] **Test Validation Errors**
  - [ ] Try to create event with empty title
  - [ ] ✅ Should show validation error
  - [ ] Try to create event with past date
  - [ ] ✅ Should show validation error
  - [ ] Try to create event with invalid time format
  - [ ] ✅ Should show validation error

- [ ] **Test Authentication Errors**
  - [ ] Logout
  - [ ] Try to access dashboard
  - [ ] ✅ Should redirect to login
  - [ ] Try to create event without login
  - [ ] ✅ Should redirect to login

- [ ] **Test Database Errors**
  - [ ] Try to register with duplicate email
  - [ ] ✅ Should show "User already exists" error
  - [ ] Try to delete event you didn't create
  - [ ] ✅ Should show authorization error

## 📋 API Testing (Postman)

- [ ] **Import Postman Collection**
  - [ ] Import `EventPlanner_API.postman_collection.json`
  - [ ] ✅ Collection loads correctly
  - [ ] ✅ All endpoints visible

- [ ] **Test All Endpoints**
  - [ ] Auth: Register, Login
  - [ ] Events: Create, Get Organized, Get Invited, Get by ID, Update, Delete, Search
  - [ ] Invitations: Invite, Get Event Invitations, Get User Invitations, Update Status, Delete
  - [ ] Attendance: Set Status, Get Event Attendance, Get User Attendance
  - [ ] Users: Search

- [ ] **Test Authentication Flow**
  - [ ] Register user → Get token
  - [ ] Use token in Authorization header
  - [ ] ✅ All protected endpoints work with token
  - [ ] ✅ Endpoints fail without token

## 📦 Phase 1 Deliverables

- [ ] **Text File**
  - [ ] Create `ID1_ID2_ID3_TA_NAME.txt`
  - [ ] Include team names and IDs
  - [ ] Include GitHub repository links
  - [ ] ✅ TA added as collaborator

- [ ] **Postman Collection**
  - [x] ✅ Collection exists: `EventPlanner_API.postman_collection.json`
  - [ ] Verify all endpoints included
  - [ ] Test collection works

- [ ] **GitHub Repositories**
  - [ ] Backend repository created
  - [ ] Frontend repository created
  - [ ] All code committed
  - [ ] TA added as collaborator
  - [ ] Repositories are accessible

## 🚨 Common Issues to Check

### If 500 Errors Occur:
1. [ ] Check server console for detailed error logs
2. [ ] Verify database tables exist (run `setup.sql` if needed)
3. [ ] Check `.env` file configuration
4. [ ] Restart backend server
5. [ ] Check database connection

### If Authentication Fails:
1. [ ] Check JWT_SECRET in `.env`
2. [ ] Clear browser localStorage
3. [ ] Login again
4. [ ] Check token in Authorization header

### If Frontend Errors:
1. [ ] Check browser console
2. [ ] Verify backend is running
3. [ ] Check CORS configuration
4. [ ] Clear browser cache

## ✅ Final Checklist

- [ ] All Phase 1 features work correctly
- [ ] No 500 errors in server console
- [ ] No errors in browser console
- [ ] All API endpoints tested
- [ ] Error handling works properly
- [ ] Validation works correctly
- [ ] Authentication works correctly
- [ ] Database properly configured
- [ ] Deliverables prepared
- [ ] Ready for submission

## 🎯 Quick Test Script

Run these tests in order:

1. **Backend Test:**
   ```bash
   cd event-backend
   npm run test-db
   # Should show: ✅ Database connection successful!
   ```

2. **Start Backend:**
   ```bash
   cd event-backend
   npm run dev
   # Should show: 🚀 Server running on http://localhost:5000
   ```

3. **Start Frontend:**
   ```bash
   cd event-frontend
   npm start
   # Should open http://localhost:4200
   ```

4. **Test Flow:**
   - Register → Login → Create Event → View Dashboard → Invite User → Set Attendance → Search Events

## 🎉 Success Criteria

Your Phase 1 is complete when:
- ✅ All features work without errors
- ✅ All requirements are met
- ✅ Error handling works properly
- ✅ Deliverables are ready
- ✅ Code is committed to GitHub

Good luck! 🚀

