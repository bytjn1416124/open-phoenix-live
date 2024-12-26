# Pre-trained Models for OpenPhoenix-Live

## Overview
This directory contains all pre-trained models used in the OpenPhoenix-Live system.

## Directory Structure
```plaintext
models/
├── 3d_gs/              # Pretrained Gaussians
│   ├── pretrained_model.pth  # Main model weights
│   └── config.yaml     # Model configuration
└── tts/                # TTS checkpoints
    ├── coqui_model.pth # TTS model weights
    └── config.json     # Model configuration
```

## Model Requirements
- Disk Space: ~10GB total
- GPU Memory: 6GB minimum
- CUDA Support: Required

## Installation
```bash
# Download all models
make download-models

# Verify model integrity
make verify-models
```

## Model Versions
- 3D Gaussian Splatting: v1.0.0
- TTS Models: Coqui v1.2.0
