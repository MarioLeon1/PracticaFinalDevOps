// tests/unit/auth.test.js
const { validateUser } = require('../../server/auth');

describe('Authentication Tests', () => {
  test('validateUser returns true for valid credentials', () => {
    const user = {
      username: 'testuser',
      password: 'validpassword'
    };
    expect(validateUser(user)).toBeTruthy();
  });

  test('validateUser returns false for invalid credentials', () => {
    const user = {
      username: 'testuser',
      password: ''
    };
    expect(validateUser(user)).toBeFalsy();
  });
});