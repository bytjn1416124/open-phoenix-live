#!/bin/bash

# Exit on error
set -e

echo "Verifying model files..."

# Required model files
GAUSSIAN_FILES=(
    "models/3d_gs/pretrained_model.pth"
    "models/3d_gs/config.yaml"
)

TTS_FILES=(
    "models/tts/coqui_model.pth"
    "models/tts/config.json"
)

# Check Gaussian Splatting models
echo "Checking 3D Gaussian models..."
for file in "${GAUSSIAN_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Missing required file: $file"
        exit 1
    fi
done

# Check TTS models
echo "Checking TTS models..."
for file in "${TTS_FILES[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Missing required file: $file"
        exit 1
    fi
done

echo "All model files verified successfully!"
