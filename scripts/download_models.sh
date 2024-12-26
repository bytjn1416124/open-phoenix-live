#!/bin/bash

# Exit on error
set -e

echo "Downloading pre-trained models..."

# Create models directory if it doesn't exist
mkdir -p models

# Download STT model
if [ ! -d "models/stt/vosk-model-small-en-us" ]; then
    echo "Downloading STT model..."
    wget https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip
    unzip vosk-model-small-en-us-0.15.zip -d models/stt/
    rm vosk-model-small-en-us-0.15.zip
fi

# Download TTS model
if [ ! -d "models/tts/coqui-model" ]; then
    echo "Downloading TTS model..."
    mkdir -p models/tts/coqui-model
    # Add actual TTS model download command here
fi

# Download 3D Gaussian Splatting model
if [ ! -d "models/3d_gs/pretrained" ]; then
    echo "Downloading 3D GS model..."
    mkdir -p models/3d_gs/pretrained
    # Add actual 3D GS model download command here
fi

echo "Model download complete!"