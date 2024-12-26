#!/bin/bash

# Exit on error
set -e

# Run Python tests
pytest tests/ --cov=server --cov-report=xml

# Run React tests
cd client
npm test -- --coverage

# Run integration tests
pytest tests/integration/ --cov=server --cov-append