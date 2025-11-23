# Project Structure Overview

```
phase-0/
│
├── 📄 README.md                          # Main project documentation
├── 📄 SETUP_GUIDE.md                     # Detailed setup instructions
├── 📄 POSTMAN_COLLECTION.md              # API testing guide
│
├── 📁 event-backend/                     # Node.js + Express Backend
│   │
│   ├── 📁 src/
│   │   ├── 📁 config/
│   │   │   └── 📄 db.js                  # PostgreSQL connection pool
│   │   │
│   │   ├── 📁 models/
│   │   │   └── 📄 user.model.js          # User database operations
│   │   │
│   │   ├── 📁 controllers/
│   │   │   └── 📄 auth.controller.js     # Registration & login logic
│   │   │
│   │   ├── 📁 routes/
│   │   │   └── 📄 auth.routes.js         # API route definitions
│   │   │
│   │   └── 📄 server.js                  # Express server setup
│   │
│   ├── 📄 package.json                   # Backend dependencies
│   ├── 📄 .gitignore                     # Git ignore rules
│   ├── 📄 README.md                      # Backend documentation
│   ├── 📄 setup.sql                      # Database schema
│   └── 📄 .env                           # Environment variables (create this!)
│
└── 📁 event-frontend/                    # Angular Frontend
    │
    ├── 📁 src/
    │   ├── 📁 app/
    │   │   ├── 📁 components/
    │   │   │   ├── 📁 login/
    │   │   │   │   ├── 📄 login.component.ts
    │   │   │   │   ├── 📄 login.component.html
    │   │   │   │   └── 📄 login.component.css
    │   │   │   │
    │   │   │   └── 📁 register/
    │   │   │       ├── 📄 register.component.ts
    │   │   │       ├── 📄 register.component.html
    │   │   │       └── 📄 register.component.css
    │   │   │
    │   │   ├── 📁 services/
    │   │   │   └── 📄 auth.service.ts     # HTTP requests to backend
    │   │   │
    │   │   ├── 📄 app.module.ts           # Angular module configuration
    │   │   ├── 📄 app.component.ts        # Root component
    │   │   ├── 📄 app.component.html      # Root template
    │   │   └── 📄 app.component.css       # Root styles
    │   │
    │   ├── 📄 index.html                  # Main HTML file
    │   ├── 📄 styles.css                  # Global styles
    │   └── 📄 main.ts                     # Application entry point
    │
    ├── 📄 package.json                    # Frontend dependencies
    ├── 📄 angular.json                    # Angular configuration
    ├── 📄 tsconfig.json                   # TypeScript configuration
    ├── 📄 .gitignore                      # Git ignore rules
    └── 📄 README.md                       # Frontend documentation
```

## Key Files Explained

### Backend Files

| File | Purpose |
|------|---------|
| `src/server.js` | Express server, middleware setup, route mounting |
| `src/config/db.js` | PostgreSQL connection pool configuration |
| `src/models/user.model.js` | Database operations (create, find users) |
| `src/controllers/auth.controller.js` | Business logic (register, login, hash passwords) |
| `src/routes/auth.routes.js` | Route definitions and handlers mapping |
| `setup.sql` | SQL script to create users table |
| `.env` | Environment variables (database, JWT secret) |

### Frontend Files

| File | Purpose |
|------|---------|
| `src/main.ts` | Bootstrap Angular application |
| `src/app/app.module.ts` | Declare components, imports, providers |
| `src/app/app.component.*` | Root component (switches between login/register) |
| `src/app/components/login/` | Login form component |
| `src/app/components/register/` | Registration form component |
| `src/app/services/auth.service.ts` | HTTP client service for API calls |
| `angular.json` | Angular workspace configuration |
| `tsconfig.json` | TypeScript compiler options |

## Data Flow

```
User Input (Frontend)
    ↓
Angular Component (login/register.component.ts)
    ↓
Auth Service (auth.service.ts)
    ↓
HTTP Request → Backend API
    ↓
Express Route (auth.routes.js)
    ↓
Controller (auth.controller.js)
    ↓
Model (user.model.js)
    ↓
PostgreSQL Database
    ↓
Response with JWT Token
    ↓
Store in localStorage
```

## Environment Variables

**Backend `.env` file:**
```env
PORT=5000
DB_USER=postgres
DB_PASS=your_password
DB_NAME=event_db
DB_HOST=localhost
DB_PORT=5432
JWT_SECRET=mysecretkey
```

## Ports

- **Backend:** `http://localhost:5000`
- **Frontend:** `http://localhost:4200`
- **PostgreSQL:** `localhost:5432` (default)

## Dependencies Summary

### Backend
- `express` - Web framework
- `pg` - PostgreSQL client
- `bcrypt` - Password hashing
- `jsonwebtoken` - JWT generation
- `dotenv` - Environment variables
- `cors` - Cross-origin resource sharing

### Frontend
- `@angular/*` - Angular framework
- `rxjs` - Reactive programming
- `@angular/forms` - Form handling
- `@angular/common/http` - HTTP client

## Important Notes

1. **Always run backend before frontend** - Frontend depends on backend API
2. **Create `.env` file** - Backend won't work without it
3. **Set up database first** - Run `setup.sql` before starting backend
4. **Two terminals needed** - One for backend, one for frontend
5. **Check ports** - 5000 (backend) and 4200 (frontend) must be available
