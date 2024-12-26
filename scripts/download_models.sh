#!/bin/bash

# Exit on error
set -e

echo "Downloading pre-trained models..."

# Create models directory if it doesn't exist
mkdir -p models

# Download STT model
if [ "$1" = "stt" ] || [ -z "$1" ]; then
    if [ ! -d "models/stt/vosk-model-small-en-us" ]; then
        echo "Downloading STT model..."
        wget https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip
        unzip vosk-model-small-en-us-0.15.zip -d models/stt/
        rm vosk-model-small-en-us-0.15.zip
        cp config/stt_config.json models/stt/config.json
    fi
fi

# Download TTS model
if [ "$1" = "tts" ] || [ -z "$1" ]; then
    if [ ! -d "models/tts/coqui_model.pth" ]; then
        echo "Downloading TTS model..."
        # Add TTS model download command here
        cp config/tts_config.json models/tts/config.json
    fi
fi

# Download 3D Gaussian model
if [ "$1" = "gaussian" ] || [ -z "$1" ]; then
    if [ ! -f "models/3d_gs/pretrained_model.pth" ]; then
        echo "Downloading 3D Gaussian model..."
        # Add 3D Gaussian model download command here
        cp config/gaussian_config.yaml models/3d_gs/config.yaml
    fi
fi

echo "Model download complete!"
