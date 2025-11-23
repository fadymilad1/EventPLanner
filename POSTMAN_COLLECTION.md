# Postman Collection - Event Planner API (Phase 0)

This document provides testing instructions for the Event Planner authentication endpoints.

## Setup

1. Install Postman from [https://www.postman.com/downloads/](https://www.postman.com/downloads/)
2. Import the collection or manually test the endpoints

## Environment Variables

Create a new environment in Postman with:
- `base_url`: `http://localhost:5000`
- `token`: (will be set automatically after login)

## API Endpoints

### 1. Health Check
**GET** `http://localhost:5000/`

**Response:**
```json
{
  "message": "Event Planner API - Phase 0"
}
```

---

### 2. Register User

**Method:** `POST`  
**URL:** `http://localhost:5000/api/auth/register`  
**Headers:**
```
Content-Type: application/json
```

**Body (raw JSON):**
```json
{
  "email": "test@example.com",
  "password": "password123"
}
```

**Success Response (201):**
```json
{
  "message": "User registered successfully",
  "user": {
    "id": 1,
    "email": "test@example.com",
    "created_at": "2024-01-01T12:00:00.000Z"
  }
}
```

**Error Responses:**

Missing fields (400):
```json
{
  "message": "Email and password are required"
}
```

User already exists (400):
```json
{
  "message": "User with this email already exists"
}
```

---

### 3. Login

**Method:** `POST`  
**URL:** `http://localhost:5000/api/auth/login`  
**Headers:**
```
Content-Type: application/json
```

**Body (raw JSON):**
```json
{
  "email": "test@example.com",
  "password": "password123"
}
```

**Success Response (200):**
```json
{
  "message": "Login successful",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "email": "test@example.com"
  }
}
```

**Error Responses:**

Missing fields (400):
```json
{
  "message": "Email and password are required"
}
```

Invalid credentials (401):
```json
{
  "message": "Invalid email or password"
}
```

---

## Testing Workflow

### Complete Flow Test

1. **Register a new user:**
   - POST to `/api/auth/register`
   - Save the user details from response

2. **Login with registered credentials:**
   - POST to `/api/auth/login`
   - Save the JWT token from response
   - Use this token in Authorization header for protected routes (in future phases)

3. **Verify token in localStorage (Frontend):**
   - Open browser DevTools
   - Check Application > Local Storage
   - Token should be stored as `token`

### Error Testing

1. **Try registering with duplicate email**
2. **Try logging in with wrong password**
3. **Try logging in with non-existent email**
4. **Try calling endpoints with missing fields**

## Using cURL

### Register
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

### Login
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

## Troubleshooting

- **Connection refused:** Make sure backend server is running
- **Database error:** Ensure PostgreSQL is running and credentials are correct
- **CORS error:** Check backend CORS configuration allows `http://localhost:4200`
- **500 error:** Check backend console for detailed error messages
