#!/bin/bash

# Exit on error
set -e

echo "Setting up OpenPhoenix Live environment..."

# Create Python virtual environment
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
pip install --upgrade pip
pip install -r requirements.txt

# Create necessary directories
mkdir -p models/stt
mkdir -p models/tts
mkdir -p models/3d_gs

# Install Node.js dependencies
cd client
npm install
cd ..

echo "Setup complete!"
echo "Run 'source venv/bin/activate' to activate the virtual environment"