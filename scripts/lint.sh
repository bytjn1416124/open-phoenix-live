#!/bin/bash

# Exit on error
set -e

# Run Python linters
flake8 server/
black --check server/
isort --check-only server/

# Run JavaScript linters
cd client
npm run lint