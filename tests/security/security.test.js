// tests/security/security.test.js
const ZapClient = require('zaproxy');

describe('Security Tests', () => {
  let zaproxy;

  beforeAll(() => {
    zaproxy = new ZapClient({
      apiKey: process.env.ZAP_API_KEY,
      proxy: 'http://localhost:8080'
    });
  });

  test('No high-risk vulnerabilities found', async () => {
    const results = await zaproxy.spider.scan({
      url: 'http://localhost:3000'
    });
    expect(results.high).toBe(0);
  });
});