# primeira-pipeline-cicd

[![CI/CD Pipeline](https://github.com/bolismar69/primeira-pipeline-cicd/actions/workflows/ci.yml/badge.svg)](https://github.com/bolismar69/primeira-pipeline-cicd/actions/workflows/ci.yml)

A simple Node.js Express application demonstrating CI/CD pipeline implementation with GitHub Actions.

## About

This project demonstrates a basic CI/CD pipeline setup using:
- **Express.js** - Web framework for Node.js
- **Jest** - Testing framework
- **ESLint** - Code linting and quality
- **GitHub Actions** - Continuous Integration and Deployment

## Features

- Simple REST API with Express.js
- Automated testing with Jest
- Code quality checks with ESLint
- CI/CD pipeline with GitHub Actions
- Multi-version Node.js support (18.x, 20.x)

## API Endpoints

- `GET /` - Welcome message
- `GET /health` - Health check endpoint
- `POST /echo` - Echo endpoint that returns the request body

## Getting Started

### Prerequisites

- Node.js 18.x or higher
- npm

### Installation

```bash
# Clone the repository
git clone https://github.com/bolismar69/primeira-pipeline-cicd.git
cd primeira-pipeline-cicd

# Install dependencies
npm install
```

### Running the Application

```bash
# Start the server
npm start

# The server will run on http://localhost:3000
```

### Running Tests

```bash
# Run all tests
npm test
```

### Running Linter

```bash
# Check code quality
npm run lint
```

## CI/CD Pipeline

The GitHub Actions workflow automatically:
1. Checks out the code
2. Sets up Node.js environment
3. Installs dependencies
4. Runs ESLint for code quality
5. Executes all tests
6. Validates the build

The pipeline runs on:
- Push to `main` branch
- Pull requests to `main` branch
- Multiple Node.js versions (18.x, 20.x)

## Project Structure

```
primeira-pipeline-cicd/
├── .github/
│   └── workflows/
│       └── ci.yml          # GitHub Actions workflow
├── index.js                # Main application file
├── index.test.js           # Test file
├── package.json            # Project dependencies and scripts
├── eslint.config.mjs       # ESLint configuration
└── README.md               # Project documentation
```

## License

ISC

