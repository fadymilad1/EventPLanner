# 🚀 START HERE - Event Planner Phase 0 Complete!

## ✅ What's Been Built

A complete **User Authentication System** with:
- ✅ Node.js/Express backend with PostgreSQL
- ✅ Angular frontend with beautiful UI
- ✅ JWT token-based authentication
- ✅ Secure password hashing with bcrypt
- ✅ User registration and login
- ✅ Full documentation and guides

---

## 📁 What You Have

```
phase-0/
├── 📖 START_HERE.md (you are here!)
├── 📖 QUICK_START.md (5-minute setup guide)
├── 📖 SETUP_GUIDE.md (detailed setup instructions)
├── 📖 POSTMAN_COLLECTION.md (API testing guide)
├── 📖 PROJECT_STRUCTURE.md (code organization)
├── 📖 README.md (complete documentation)
│
├── 📂 event-backend/ (Node.js + Express + PostgreSQL)
│   ├── src/
│   │   ├── config/db.js
│   │   ├── models/user.model.js
│   │   ├── controllers/auth.controller.js
│   │   ├── routes/auth.routes.js
│   │   └── server.js
│   ├── package.json
│   ├── setup.sql
│   └── README.md
│
└── 📂 event-frontend/ (Angular)
    ├── src/
    │   ├── app/
    │   │   ├── components/login/
    │   │   ├── components/register/
    │   │   ├── services/auth.service.ts
    │   │   └── app.module.ts
    │   ├── index.html
    │   └── styles.css
    ├── package.json
    └── README.md
```

---

## 🎯 What to Do Next

### Option 1: Quick Start (Recommended for experienced developers)
**Read:** [QUICK_START.md](./QUICK_START.md)

### Option 2: Detailed Setup (Recommended for beginners)
**Read:** [SETUP_GUIDE.md](./SETUP_GUIDE.md)

### Option 3: Just Give Me Commands
**Continue reading below ⬇️**

---

## 🏃‍♂️ Fastest Way to Run

### 1. Database (One-time setup)
```bash
psql -U postgres
CREATE DATABASE event_db;
\c event_db
CREATE TABLE users (id SERIAL PRIMARY KEY, email VARCHAR(255) UNIQUE NOT NULL, password TEXT NOT NULL, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
\q
```

### 2. Backend (Terminal 1)
```bash
cd event-backend

# Create .env file with this content:
# PORT=5000
# DB_USER=postgres
# DB_PASS=YOUR_PASSWORD
# DB_NAME=event_db
# DB_HOST=localhost
# DB_PORT=5432
# JWT_SECRET=mysecretkey

npm install
npm run dev
```

### 3. Frontend (Terminal 2)
```bash
cd event-frontend
npm install
npm start
```

### 4. Test
- Open browser: `http://localhost:4200`
- Register a user
- Login with that user
- ✅ Done!

---

## 📚 Documentation Files

| File | Purpose | Read When |
|------|---------|-----------|
| `START_HERE.md` | Overview and navigation | First |
| `QUICK_START.md` | Fastest way to run | You want speed |
| `SETUP_GUIDE.md` | Detailed setup steps | You're new to this |
| `POSTMAN_COLLECTION.md` | Test API endpoints | You want to test API |
| `PROJECT_STRUCTURE.md` | Code organization | You want to understand structure |
| `README.md` | Complete documentation | You want everything |

---

## 🎨 Features

### Backend
- ✅ RESTful API with Express
- ✅ PostgreSQL database with connection pooling
- ✅ JWT token generation
- ✅ Password hashing with bcrypt
- ✅ CORS enabled for Angular frontend
- ✅ Error handling and validation
- ✅ Clean, modular code structure

### Frontend
- ✅ Angular 16 with TypeScript
- ✅ Two-way data binding forms
- ✅ Token storage in localStorage
- ✅ Success/Error notifications
- ✅ Beautiful gradient UI
- ✅ Responsive design
- ✅ Form validation

### Security
- ✅ Password hashing (bcrypt, 10 rounds)
- ✅ JWT tokens with expiration (24h)
- ✅ Secure token storage
- ✅ Input validation
- ✅ SQL injection protection (parameterized queries)

---

## 🧪 Testing

### Manual Testing (Frontend)
1. Register a new user
2. Login with credentials
3. Check localStorage for JWT token
4. Try duplicate registration (should fail)
5. Try wrong password (should fail)

### API Testing (Postman/cURL)
See [POSTMAN_COLLECTION.md](./POSTMAN_COLLECTION.md)

### Example cURL Commands
```bash
# Register
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Login
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'
```

---

## 🎓 Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend Framework | Angular 16 |
| Backend Framework | Node.js + Express |
| Database | PostgreSQL |
| Authentication | JWT (JSON Web Tokens) |
| Password Hashing | bcrypt |
| Styling | CSS (with modern gradient) |
| HTTP Client | Angular HttpClient |

---

## 🔄 Data Flow

```
1. User fills form (Angular)
   ↓
2. Component sends data to AuthService
   ↓
3. AuthService makes HTTP request (HTTPClient)
   ↓
4. Express receives request (Backend)
   ↓
5. AuthController processes request
   ↓
6. UserModel queries PostgreSQL
   ↓
7. Database returns result
   ↓
8. JWT token generated
   ↓
9. Response sent back
   ↓
10. Token stored in localStorage
    ↓
11. User authenticated ✅
```

---

## 📍 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Health check |
| POST | `/api/auth/register` | Register new user |
| POST | `/api/auth/login` | Login and get JWT |

**Base URL:** `http://localhost:5000`

---

## 🆘 Need Help?

### Common Issues

1. **Backend won't start**
   - Check PostgreSQL is running
   - Verify `.env` file exists with correct credentials

2. **Frontend can't connect**
   - Make sure backend is running
   - Check backend is on port 5000

3. **Database errors**
   - Run `setup.sql` to create tables
   - Verify database name and user

### Get Help
- Check [SETUP_GUIDE.md](./SETUP_GUIDE.md) for detailed troubleshooting
- Read error messages in console/terminal
- Check browser DevTools (F12) for frontend errors

---

## 🎉 Success Checklist

Before moving to Phase 1, make sure:

- [ ] PostgreSQL database created and connected
- [ ] Users table exists in database
- [ ] Backend server runs without errors
- [ ] Frontend runs and displays forms
- [ ] Can register a new user successfully
- [ ] Can login with registered credentials
- [ ] JWT token appears in localStorage
- [ ] Error messages display correctly
- [ ] Can test API with Postman/cURL

---

## 🚀 Next Steps

After Phase 0 is working:

**Phase 1 Ideas:**
- Add protected routes with JWT middleware
- Create user profile page
- Add event management (CRUD)
- Implement event details page
- Add role-based access control

**Current Phase 0 Features:**
✅ User Registration
✅ User Login
✅ JWT Authentication
✅ Secure Password Storage
✅ Token Management

---

## 💡 Pro Tips

1. **Keep both terminals open** - Backend and frontend need to run simultaneously
2. **Check the console** - Backend terminal shows connection status and errors
3. **Use browser DevTools** - See localStorage, network requests, and console errors
4. **Test error cases** - Try duplicate emails, wrong passwords, empty fields
5. **Read the code** - Comments explain what each part does

---

## 📝 File Creation Checklist

You need to manually create:
- [x] All backend files ✅
- [x] All frontend files ✅
- [x] All documentation ✅
- [ ] **.env file** ⚠️ Create this in `event-backend/` folder!

The `.env` file is not included for security reasons. Copy from `QUICK_START.md` or `SETUP_GUIDE.md`.

---

## 🎯 You're Ready!

Everything is set up. Choose your starting point:

1. 🚀 [QUICK_START.md](./QUICK_START.md) - Fastest way
2. 📖 [SETUP_GUIDE.md](./SETUP_GUIDE.md) - Detailed guide
3. 🧪 [POSTMAN_COLLECTION.md](./POSTMAN_COLLECTION.md) - Test API
4. 📁 [PROJECT_STRUCTURE.md](./PROJECT_STRUCTURE.md) - Understand structure

**Good luck! Happy coding! 🚀**
