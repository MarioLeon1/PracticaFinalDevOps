// tests/integration/api.test.js
const request = require('supertest');
const app = require('../../server/server');

describe('API Integration Tests', () => {
  test('GET /api/health returns 200', async () => {
    const response = await request(app).get('/api/health');
    expect(response.statusCode).toBe(200);
  });

  test('POST /api/login with valid credentials', async () => {
    const response = await request(app)
      .post('/api/login')
      .send({
        username: 'testuser',
        password: 'testpass'
      });
    expect(response.statusCode).toBe(200);
  });
});