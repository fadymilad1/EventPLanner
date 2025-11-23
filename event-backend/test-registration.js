/**
 * Test Registration Endpoint
 * This script tests the registration endpoint directly
 */

require('dotenv').config();
const http = require('http');

const testData = {
  email: `test${Date.now()}@example.com`,
  password: 'testpassword123'
};

const postData = JSON.stringify(testData);

const options = {
  hostname: 'localhost',
  port: 5000,
  path: '/api/auth/register',
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': Buffer.byteLength(postData)
  }
};

console.log('Testing registration endpoint...');
console.log('Test data:', testData);
console.log('');

const req = http.request(options, (res) => {
  let data = '';

  res.on('data', (chunk) => {
    data += chunk;
  });

  res.on('end', () => {
    console.log('Status Code:', res.statusCode);
    console.log('Response:', data);
    
    try {
      const json = JSON.parse(data);
      console.log('\nParsed Response:');
      console.log(JSON.stringify(json, null, 2));
    } catch (e) {
      console.log('Response is not JSON');
    }
  });
});

req.on('error', (error) => {
  console.error('Request Error:', error.message);
  console.error('\n💡 Make sure the server is running: npm run dev');
});

req.write(postData);
req.end();

