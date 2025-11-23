# Event Planner - Phase 1 Implementation

## Overview

Phase 1 of the Event Planner application is now complete! This phase includes all the core features for event management, user invitations, and attendance tracking.

## What's Included

### Backend (Node.js + Express.js)

- **Authentication**: JWT-based user authentication (register/login)
- **Event Management**: CRUD operations for events
- **Invitations**: Invite users to events with roles (organizer/attendee)
- **Attendance**: Track attendance status (Going, Maybe, Not Going)
- **Search**: Advanced event search with filters
- **User Search**: Search users by email for invitations
- **Validation**: Input validation using express-validator
- **Error Handling**: Centralized error handling middleware
- **Database**: PostgreSQL with proper schema and indexes

### Frontend (Angular)

- **Dashboard**: View organized and invited events
- **Event Creation**: Create and edit events
- **Event Details**: View event details, invitations, and attendance
- **Attendance Management**: Set attendance status for events
- **Event Search**: Search events with filters
- **User Search**: Search users when inviting to events
- **Routing**: Angular routing with authentication guards
- **HTTP Interceptor**: Automatic JWT token injection
- **Responsive UI**: Modern, responsive user interface

## Project Structure

```
EventPLanner-main/
├── event-backend/
│   ├── src/
│   │   ├── config/          # Database configuration
│   │   ├── controllers/     # Request handlers
│   │   ├── models/          # Database models
│   │   ├── routes/          # API routes
│   │   ├── middleware/      # Auth and error middleware
│   │   ├── validators/      # Input validation
│   │   └── server.js        # Express server
│   ├── setup.sql            # Database schema
│   ├── package.json         # Dependencies
│   └── EventPlanner_API.postman_collection.json
│
└── event-frontend/
    └── src/
        └── app/
            ├── components/  # Angular components
            ├── services/    # API services
            ├── guards/      # Route guards
            └── app.module.ts
```

## Quick Start

### 1. Backend Setup

```bash
cd event-backend
npm install
# Create .env file with database credentials
psql -U postgres -d event_db -f setup.sql
npm run dev
```

### 2. Frontend Setup

```bash
cd event-frontend
npm install
ng serve
```

### 3. Access Application

- Frontend: http://localhost:4200
- Backend API: http://localhost:5000

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user

### Events
- `POST /api/events` - Create event
- `GET /api/events/organized` - Get organized events
- `GET /api/events/invited` - Get invited events
- `GET /api/events/:id` - Get event by ID
- `PUT /api/events/:id` - Update event
- `DELETE /api/events/:id` - Delete event
- `GET /api/events/search` - Search events

### Invitations
- `POST /api/events/:eventId/invitations` - Invite user
- `GET /api/events/:eventId/invitations` - Get event invitations
- `GET /api/invitations` - Get user invitations
- `PUT /api/invitations/:eventId` - Update invitation status
- `DELETE /api/events/:eventId/invitations/:inviteeId` - Delete invitation

### Attendance
- `POST /api/events/:eventId/attendance` - Set attendance status
- `GET /api/events/:eventId/attendance` - Get event attendance
- `GET /api/events/:eventId/attendance/me` - Get my attendance
- `GET /api/attendance` - Get my attending events

### Users
- `GET /api/users/search` - Search users by email

## Database Schema

### Tables
- `users` - User accounts
- `events` - Event information
- `event_invitations` - Event invitations
- `event_attendance` - Attendance records

See `event-backend/setup.sql` for complete schema.

## Testing

### Postman Collection
Import `event-backend/EventPlanner_API.postman_collection.json` into Postman to test all API endpoints.

### Manual Testing
1. Register a new user
2. Login and create an event
3. Invite other users to the event
4. Set attendance status
5. Search for events

## Key Features

### Event Management
- Create events with title, date, time, location, and description
- View all events you've organized
- View all events you're invited to
- Edit and delete your events
- Search events with filters

### Invitations
- Invite users to events
- Assign roles (organizer/attendee)
- View invitation status
- Accept/decline invitations
- Remove invitations

### Attendance
- Set attendance status (Going, Maybe, Not Going)
- View attendance for events (organizers only)
- View attendance statistics
- Filter events by attendance status

### User Search
- Search users by email
- Real-time search results
- Select users to invite

## Security Features

- JWT-based authentication
- Password hashing with bcrypt
- Protected routes with authentication middleware
- Input validation and sanitization
- SQL injection prevention (parameterized queries)
- CORS configuration
- Error handling without exposing sensitive information

## Error Handling

- Centralized error middleware
- Proper HTTP status codes
- Clear error messages
- Validation error handling
- Database error handling

## Validation

- Event creation/update validation
- Email format validation
- Date and time validation
- Required field validation
- Length constraints
- Date range validation

## Next Steps

See `PHASE1_SETUP.md` for detailed setup instructions and troubleshooting guide.

## Support

For issues or questions:
1. Check the setup guide: `PHASE1_SETUP.md`
2. Review backend logs
3. Check browser console for frontend errors
4. Review network tab for API requests/responses

## License

This project is part of the Event Planner application.

