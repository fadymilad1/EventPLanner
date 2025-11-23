# Event Planner - Phase 1 Setup Guide

This guide will help you set up and run the Event Planner application (Phase 1) locally.

## Prerequisites

- **Node.js** (v14 or higher)
- **PostgreSQL** (v12 or higher)
- **Angular CLI** (v16 or higher)
- **npm** or **yarn**

## Backend Setup

### 1. Install Dependencies

```bash
cd event-backend
npm install
```

### 2. Database Setup

1. Create a PostgreSQL database:

```sql
CREATE DATABASE event_db;
```

2. Update the database connection in `.env` file (create `.env` from `.env.example`):

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

3. Run the database setup script:

```bash
psql -U postgres -d event_db -f setup.sql
```

Or manually execute the SQL commands from `setup.sql` in your PostgreSQL client.

### 3. Start the Backend Server

```bash
# Development mode (with auto-reload)
npm run dev

# Production mode
npm start
```

The server will start on `http://localhost:5000`

## Frontend Setup

### 1. Install Dependencies

```bash
cd event-frontend
npm install
```

### 2. Start the Frontend Development Server

```bash
ng serve
```

The frontend will start on `http://localhost:4200`

## Testing the Application

### 1. Register a User

1. Open `http://localhost:4200` in your browser
2. Click on "Register here" if you're on the login page
3. Fill in your email and password
4. Click "Register"

### 2. Login

1. After registration, you'll be redirected to the login page
2. Enter your email and password
3. Click "Login"
4. You'll be redirected to the dashboard

### 3. Create an Event

1. From the dashboard, click "Create Event"
2. Fill in the event details:
   - Title (required, min 3 characters)
   - Description (optional)
   - Date (required)
   - Time (required, 24-hour format)
   - Location (required, min 3 characters)
3. Click "Create Event"

### 4. Invite Users

1. View an event you created
2. Start typing a user's email in the search field
3. Select a user from the search results
4. The user will be invited to the event

### 5. Set Attendance Status

1. View an event you're invited to
2. Click on "Going", "Maybe", or "Not Going"
3. Your attendance status will be updated

### 6. Search Events

1. Click "Search Events" from the dashboard
2. Enter search criteria:
   - Keyword (searches title and description)
   - Date range (start and end dates)
   - Role (organizer or attendee)
3. Click "Search"

## API Testing with Postman

1. Import the Postman collection: `event-backend/EventPlanner_API.postman_collection.json`
2. Set the `baseUrl` variable to `http://localhost:5000/api`
3. Start with the "Register" or "Login" request to get a token
4. The token will be automatically stored in the `token` variable after login
5. Use the token for all authenticated requests

## Project Structure

### Backend Structure

```
event-backend/
├── src/
│   ├── config/
│   │   └── db.js              # Database configuration
│   ├── controllers/
│   │   ├── auth.controller.js
│   │   ├── event.controller.js
│   │   ├── invitation.controller.js
│   │   └── attendance.controller.js
│   ├── models/
│   │   ├── user.model.js
│   │   ├── event.model.js
│   │   ├── invitation.model.js
│   │   └── attendance.model.js
│   ├── routes/
│   │   ├── auth.routes.js
│   │   ├── event.routes.js
│   │   ├── invitation.routes.js
│   │   └── attendance.routes.js
│   ├── middleware/
│   │   ├── auth.middleware.js
│   │   └── error.middleware.js
│   ├── validators/
│   │   └── event.validator.js
│   └── server.js
├── setup.sql
├── package.json
└── .env.example
```

### Frontend Structure

```
event-frontend/
├── src/
│   ├── app/
│   │   ├── components/
│   │   │   ├── login/
│   │   │   ├── register/
│   │   │   ├── dashboard/
│   │   │   ├── event-form/
│   │   │   ├── event-details/
│   │   │   └── event-search/
│   │   ├── services/
│   │   │   ├── auth.service.ts
│   │   │   ├── auth.interceptor.ts
│   │   │   ├── event.service.ts
│   │   │   ├── invitation.service.ts
│   │   │   └── attendance.service.ts
│   │   ├── guards/
│   │   │   └── auth.guard.ts
│   │   ├── app.module.ts
│   │   └── app.component.ts
│   └── index.html
└── package.json
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login user

### Events
- `POST /api/events` - Create a new event
- `GET /api/events/organized` - Get events organized by user
- `GET /api/events/invited` - Get events user is invited to
- `GET /api/events/:id` - Get event by ID
- `PUT /api/events/:id` - Update an event
- `DELETE /api/events/:id` - Delete an event
- `GET /api/events/search` - Search events with filters

### Invitations
- `POST /api/events/:eventId/invitations` - Invite a user to an event
- `GET /api/events/:eventId/invitations` - Get invitations for an event
- `GET /api/invitations` - Get user's invitations
- `PUT /api/invitations/:eventId` - Update invitation status
- `DELETE /api/events/:eventId/invitations/:inviteeId` - Delete an invitation

### Users
- `GET /api/users/search` - Search users by email

### Attendance
- `POST /api/events/:eventId/attendance` - Set attendance status
- `GET /api/events/:eventId/attendance` - Get event attendance (organizer only)
- `GET /api/events/:eventId/attendance/me` - Get user's attendance for an event
- `GET /api/attendance` - Get user's attending events

## Database Schema

### Tables
- `users` - User accounts
- `events` - Event information
- `event_invitations` - Event invitations
- `event_attendance` - Event attendance records

See `setup.sql` for complete schema definition.

## Troubleshooting

### Backend Issues

1. **Database connection error**
   - Check PostgreSQL is running
   - Verify database credentials in `.env`
   - Ensure database exists

2. **Port already in use**
   - Change `PORT` in `.env`
   - Or stop the process using port 5000

3. **JWT token errors**
   - Ensure `JWT_SECRET` is set in `.env`
   - Clear browser localStorage and login again

### Frontend Issues

1. **CORS errors**
   - Ensure backend CORS is configured for `http://localhost:4200`
   - Check backend is running

2. **Authentication errors**
   - Check token is stored in localStorage
   - Verify token is sent in request headers
   - Login again if token expired

3. **Routing issues**
   - Ensure all routes are defined in `app.module.ts`
   - Check Angular router is imported

## Features Implemented

✅ User authentication (register/login)  
✅ Event creation, viewing, editing, and deletion  
✅ User invitations to events  
✅ Attendance status management (Going, Maybe, Not Going)  
✅ Event search with filters (keyword, date range, role)  
✅ User search for invitations  
✅ Organized and invited events views  
✅ Attendance statistics for organizers  
✅ JWT-based authentication  
✅ Comprehensive error handling  
✅ Input validation  

## Next Steps

- Add event reminders/notifications
- Add file uploads for event images
- Implement event categories/tags
- Add event comments/discussion
- Implement event recurrence
- Add event analytics/reports
- Add email notifications for invitations
- Implement event templates

## Support

For issues or questions, please check:
- Backend logs in terminal
- Browser console for frontend errors
- Network tab for API request/response details

