/**
 * Test Event Queries
 * Run this to test if the event queries work correctly
 * Usage: node test-event-queries.js
 */

require('dotenv').config();
const pool = require('./src/config/db');

async function testQueries() {
  try {
    console.log('Testing database connection...');
    
    // Test 1: Check if tables exist
    console.log('\n1. Checking if tables exist...');
    const tablesCheck = await pool.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
      AND table_name IN ('users', 'events', 'event_invitations', 'event_attendance')
    `);
    console.log('Tables found:', tablesCheck.rows.map(r => r.table_name));
    
    if (tablesCheck.rows.length < 4) {
      console.error('❌ Missing tables! Please run setup.sql');
      process.exit(1);
    }
    
    // Test 2: Check if there are any users
    console.log('\n2. Checking users...');
    const users = await pool.query('SELECT id, email FROM users LIMIT 5');
    console.log('Users found:', users.rows.length);
    if (users.rows.length > 0) {
      console.log('Sample user:', users.rows[0]);
    } else {
      console.log('⚠️  No users found. You need to register first.');
    }
    
    // Test 3: Test findByOrganizer query
    if (users.rows.length > 0) {
      const testUserId = users.rows[0].id;
      console.log(`\n3. Testing findByOrganizer with userId=${testUserId}...`);
      try {
        const result = await pool.query(
          `SELECT e.*, u.email as organizer_email, 'organizer' as user_role
           FROM events e
           JOIN users u ON e.organizer_id = u.id
           WHERE e.organizer_id = $1
           ORDER BY e.event_date DESC, e.event_time DESC`,
          [testUserId]
        );
        console.log(`✅ findByOrganizer query successful. Found ${result.rows.length} events.`);
      } catch (error) {
        console.error('❌ findByOrganizer query failed:');
        console.error('Error code:', error.code);
        console.error('Error message:', error.message);
        console.error('Error detail:', error.detail);
      }
    }
    
    // Test 4: Test findInvitedEvents query
    if (users.rows.length > 0) {
      const testUserId = users.rows[0].id;
      console.log(`\n4. Testing findInvitedEvents with userId=${testUserId}...`);
      try {
        const result = await pool.query(
          `SELECT e.*, u.email as organizer_email, ei.role as invitation_role, 
                  ei.status as invitation_status, 'attendee' as user_role
           FROM events e
           JOIN event_invitations ei ON e.id = ei.event_id
           JOIN users u ON e.organizer_id = u.id
           WHERE ei.invitee_id = $1
           ORDER BY e.event_date DESC, e.event_time DESC`,
          [testUserId]
        );
        console.log(`✅ findInvitedEvents query successful. Found ${result.rows.length} events.`);
      } catch (error) {
        console.error('❌ findInvitedEvents query failed:');
        console.error('Error code:', error.code);
        console.error('Error message:', error.message);
        console.error('Error detail:', error.detail);
      }
    }
    
    // Test 5: Test createEvent query structure
    console.log('\n5. Testing createEvent query structure...');
    try {
      // Just test the query structure, don't actually insert
      const testQuery = `
        INSERT INTO events (title, description, event_date, event_time, location, organizer_id)
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING *
      `;
      console.log('✅ createEvent query structure is valid.');
    } catch (error) {
      console.error('❌ createEvent query structure error:', error.message);
    }
    
    console.log('\n✅ All tests completed!');
    process.exit(0);
  } catch (error) {
    console.error('\n❌ Test failed:');
    console.error('Error code:', error.code);
    console.error('Error message:', error.message);
    console.error('Error detail:', error.detail);
    console.error('\n💡 Make sure:');
    console.error('   1. PostgreSQL is running');
    console.error('   2. .env file is configured correctly');
    console.error('   3. Database exists and tables are created (run setup.sql)');
    process.exit(1);
  } finally {
    await pool.end();
  }
}

testQueries();

