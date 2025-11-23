# Quick Start Guide

Get up and running in 5 minutes!

## Prerequisites Check

```bash
node --version    # Should be v16 or higher
npm --version     # Should be v6 or higher
psql --version    # PostgreSQL installed
```

---

## 🎯 Quick Setup

### 1. Database Setup (One-time)

```bash
# Open PostgreSQL terminal
psql -U postgres

# Run these commands:
CREATE DATABASE event_db;
\c event_db
CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(255) UNIQUE NOT NULL, password TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
\q
```

### 2. Backend Setup

```bash
cd event-backend
npm install
```

**Create `.env` file** in `event-backend/`:
```env
PORT=5000
DB_USER=postgres
DB_PASS=YOUR_PASSWORD_HERE
DB_NAME=event_db
DB_HOST=localhost
DB_PORT=5432
JWT_SECRET=mysecretkey
```

Start backend:
```bash
npm run dev
```

✅ Backend running on `http://localhost:5000`

### 3. Frontend Setup

```bash
# Open new terminal
cd event-frontend
npm install
npm start
```

✅ Frontend running on `http://localhost:4200`

---

## 🧪 Test It!

1. Open browser: `http://localhost:4200`
2. Click "Register" - create account
3. Click "Login" - sign in
4. Check DevTools (F12) > Application > Local Storage
5. See your JWT token stored!

---

## 📋 Common Commands

### Backend
```bash
npm install        # Install dependencies
npm run dev        # Start with nodemon (auto-restart)
npm start          # Start server
```

### Frontend
```bash
npm install        # Install dependencies
npm start          # Start dev server
ng serve           # Alternative command
npm run build      # Build for production
```

---

## 🐛 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| Backend won't start | Check `.env` file exists and DB credentials correct |
| Database error | Run `setup.sql` or create table manually |
| CORS errors | Backend should already have CORS configured |
| Port in use | Change PORT in `.env` to 5001, 5002, etc. |
| npm install fails | Delete `node_modules` and `package-lock.json`, try again |

---

## 📚 Full Documentation

- **Complete Setup:** [SETUP_GUIDE.md](./SETUP_GUIDE.md)
- **API Testing:** [POSTMAN_COLLECTION.md](./POSTMAN_COLLECTION.md)
- **Project Structure:** [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md)
- **Main README:** [README.md](./README.md)

---

## 🎉 You're Ready!

Your authentication system is complete. Start building Phase 1!
