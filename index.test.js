const request = require('supertest');
const app = require('./index');

describe('Express App Tests', () => {
  describe('GET /', () => {
    it('should return welcome message', async () => {
      const response = await request(app).get('/');
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('message', 'Welcome to primeira-pipeline-cicd!');
    });
  });

  describe('GET /health', () => {
    it('should return health status', async () => {
      const response = await request(app).get('/health');
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('status', 'healthy');
      expect(response.body).toHaveProperty('timestamp');
    });
  });

  describe('POST /echo', () => {
    it('should echo back the request body', async () => {
      const testData = { test: 'data', value: 123 };
      const response = await request(app)
        .post('/echo')
        .send(testData);
      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('echo');
      expect(response.body.echo).toEqual(testData);
    });
  });
});
