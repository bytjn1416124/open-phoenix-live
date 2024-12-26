# OpenPhoenix-Live: Real-Time Interactive Video Chat with AI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/downloads/)
[![Node Version](https://img.shields.io/badge/node-16%2B-green)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

## Overview

OpenPhoenix-Live is an advanced open-source system for creating interactive AI agents with real-time video conversation capabilities. Using 3D Gaussian Splatting and neural networks, it enables natural face-to-face interactions with AI.

## Project Structure

```plaintext
OpenPhoenix-Live/
├── README.md
├── docker/                  # Docker configuration
│   ├── Dockerfile.stt      # Speech-to-Text service
│   ├── Dockerfile.llm      # Language Model service
│   ├── Dockerfile.tts      # Text-to-Speech service
│   ├── Dockerfile.render   # 3D Rendering service
│   └── docker-compose.yml  # Service orchestration
├── server/                 # Backend services
│   ├── main_server.py      # Main orchestration
│   ├── stt_service.py      # Speech recognition
│   ├── llm_service.py      # Language model
│   ├── tts_service.py      # Speech synthesis
│   ├── rendering_service.py # 3D rendering
│   ├── animation/          # Animation code
│   │   └── real_time_drivers.py  # Real-time animation
│   └── utils/              # Utility functions
├── client/                 # Frontend
│   ├── public/             # Static assets
│   │   └── index.html      # Main HTML file
│   ├── cvi_app.js          # Main JS for WebRTC, displays user + agent video
│   └── src/                # React source code
└── models/                 # Pre-trained models
    ├── 3d_gs/              # Pretrained Gaussians
    │   ├── pretrained_model.pth  # Main model weights
    │   └── config.yaml     # Model configuration
    └── tts/                # TTS checkpoints
        ├── coqui_model.pth # TTS model weights
        └── config.json     # Model configuration
```

## Component Details

### Pre-trained Models

#### 1. 3D Gaussian Splatting Models (models/3d_gs/)
- **Purpose**: 3D face representation and real-time rendering
- **Files**:
  - `pretrained_model.pth`: Neural network weights for 3D Gaussian Splatting
  - `config.yaml`: Model parameters and rendering configuration

#### 2. Text-to-Speech Models (models/tts/)
- **Purpose**: Voice synthesis and audio generation
- **Files**:
  - `coqui_model.pth`: TTS model weights for voice generation
  - `config.json`: Voice configuration and synthesis parameters

### Backend Services

#### 1. Speech-to-Text Service (stt_service.py)
- Real-time speech recognition
- Audio stream processing
- Multiple language support

#### 2. Language Model Service (llm_service.py)
- Natural language understanding
- Conversation management
- Response generation

#### 3. Text-to-Speech Service (tts_service.py)
- Speech synthesis
- Voice customization
- Real-time audio streaming

#### 4. Rendering Service (rendering_service.py)
- 3D Gaussian Splatting
- Real-time animation
- Frame generation

### Frontend Components

#### 1. Video Interface (cvi_app.js)
- WebRTC implementation
- User/agent video display
- Real-time streaming

[Rest of README content...]
