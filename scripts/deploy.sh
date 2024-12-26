#!/bin/bash

# Exit on error
set -e

# Load environment variables
set -a
source .env
set +a

echo "Deploying OpenPhoenix Live..."

# Build Docker images
docker-compose build

# Deploy with Docker Compose
docker-compose up -d

echo "Deployment complete!"
echo "Access the application at http://localhost:3000"