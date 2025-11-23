require('dotenv').config();
const express = require('express');
const cors = require('cors');
const authRoutes = require('./routes/auth.routes');
const eventRoutes = require('./routes/event.routes');
const invitationRoutes = require('./routes/invitation.routes');
const attendanceRoutes = require('./routes/attendance.routes');
const userRoutes = require('./routes/user.routes');
const { errorHandler, notFoundHandler } = require('./middleware/error.middleware');

const app = express();
const PORT = process.env.PORT || 5000;

/**
 * Middleware
 */

// Request logging middleware (for debugging)
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.path}`);
  next();
});

// Enable CORS for Angular frontend
// In development, allow all origins for easier debugging
const corsOptions = {
  origin: process.env.NODE_ENV === 'production' 
    ? 'http://localhost:4200' 
    : true, // Allow all origins in development
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
};

app.use(cors(corsOptions));

// Handle preflight requests
app.options('*', cors(corsOptions));

// Parse JSON bodies
app.use(express.json());

// Parse URL-encoded bodies
app.use(express.urlencoded({ extended: true }));

/**
 * Routes
 */

// Health check route
app.get('/', (req, res) => {
  res.json({ 
    message: 'Event Planner API - Phase 1',
    status: 'running',
    timestamp: new Date().toISOString()
  });
});

// API health check
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'ok',
    message: 'API is running',
    timestamp: new Date().toISOString()
  });
});

// API routes
app.use('/api/auth', authRoutes);
app.use('/api/events', eventRoutes);
app.use('/api/invitations', invitationRoutes);
app.use('/api/attendance', attendanceRoutes);
app.use('/api/users', userRoutes);

// 404 handler
app.use(notFoundHandler);

// Error handler (must be last)
app.use(errorHandler);

/**
 * Start server
 */
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
  console.log(`📡 API endpoints available at http://localhost:${PORT}/api/auth`);
});

module.exports = app;
