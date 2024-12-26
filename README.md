# OpenPhoenix-Live: Real-Time Interactive Video Chat with AI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/downloads/)
[![Node Version](https://img.shields.io/badge/node-16%2B-green)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [System Architecture](#system-architecture)
- [Project Structure](#project-structure)
- [Component Details](#component-details)
- [Models](#models)
- [Installation](#installation)
- [Development](#development)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)
- [Citation](#citation)

## Overview

OpenPhoenix-Live is an advanced open-source system for creating interactive AI agents with real-time video conversation capabilities. Using 3D Gaussian Splatting and neural networks, it enables natural face-to-face interactions with AI agents.

## Features

### Core Capabilities
- Real-time two-way video conversations
- Natural language understanding and generation
- Expressive facial animations and lip syncing
- High-quality speech synthesis
- 3D face model rendering and manipulation

### Technical Features
- WebRTC-based video streaming
- GPU-accelerated 3D rendering
- Microservices architecture
- Docker containerization
- Real-time audio processing

## System Architecture

### Service Components
1. **Frontend Layer**
   - WebRTC video handling
   - Real-time UI updates
   - WebSocket communication
   - Media stream management

2. **Backend Services**
   - Speech recognition (STT)
   - Language processing (LLM)
   - Speech synthesis (TTS)
   - 3D rendering engine

3. **Supporting Infrastructure**
   - Redis for caching
   - WebSocket server
   - Media streaming server
   - Model serving system

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
│   ├── cvi_app.js          # Main JS for WebRTC, video display
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

### Backend Services

#### 1. Speech-to-Text Service (stt_service.py)
- **Purpose**: Real-time speech recognition
- **Features**:
  - Streaming audio processing
  - Multiple language support
  - Noise reduction
  - Real-time transcription

#### 2. Language Model Service (llm_service.py)
- **Purpose**: Natural language understanding
- **Features**:
  - Context management
  - State tracking
  - Response generation
  - Memory handling

#### 3. Text-to-Speech Service (tts_service.py)
- **Purpose**: Speech synthesis
- **Features**:
  - High-quality voice synthesis
  - Multiple voices
  - Emotion control
  - Real-time generation

#### 4. Rendering Service (rendering_service.py)
- **Purpose**: 3D face rendering
- **Features**:
  - 3D Gaussian Splatting
  - Real-time animation
  - Expression control
  - View synthesis

### Frontend Components

#### 1. Video Interface (cvi_app.js)
- **Purpose**: Real-time video communication
- **Features**:
  - WebRTC implementation
  - Video stream management
  - Media capture
  - Error handling

## Models

### 3D Gaussian Splatting Models

#### Configuration (config.yaml)
```yaml
model:
  type: gaussian_splatting
  version: "1.0"
  features:
    gaussian_count: 100000
    feature_dim: 256
    position_dim: 3
    scale_dim: 3
    rotation_dim: 4

rendering:
  resolution:
    width: 640
    height: 480
  fps: 30
  quality: high
  cuda:
    required: true
    min_memory: "6GB"

animation:
  deformation:
    enabled: true
    blendshapes: 52
    smoothing: true
```

### Text-to-Speech Models

#### Configuration (config.json)
```json
{
  "model": {
    "name": "fast_speech2",
    "version": "2.0.0",
    "architecture": {
      "encoder_layers": 4,
      "decoder_layers": 4,
      "hidden_size": 256
    }
  },
  "audio": {
    "sample_rate": 22050,
    "hop_length": 256,
    "win_length": 1024,
    "n_mel_channels": 80
  },
  "voices": {
    "enabled": ["female_1", "male_1"]
  }
}
```

## Installation

### Prerequisites

#### Hardware Requirements
- CUDA-capable GPU (6GB+ VRAM)
- CPU: 4+ cores
- RAM: 16GB+
- Storage: 20GB+
- Webcam & Microphone

#### Software Requirements
- Docker & Docker Compose
- NVIDIA Container Toolkit
- CUDA Toolkit 11.8
- Git LFS

### Setup Process

1. Clone Repository:
```bash
git clone https://github.com/bytjn1416124/open-phoenix-live.git
cd open-phoenix-live
```

2. Environment Setup:
```bash
make setup
make download-models
```

3. Configuration:
```bash
cp .env.example .env
# Edit .env with your settings
```

## Development

### Available Commands

```bash
# Setup
make setup              # Initial setup
make download-models    # Download models

# Development
make dev               # Start all services
make client            # Start frontend only
make server            # Start backend only

# Docker
make docker-build      # Build images
make docker-up         # Start services
make docker-down       # Stop services

# Testing
make test              # Run all tests
make test-unit         # Unit tests
make test-integration  # Integration tests
make lint              # Run linters

# Model Management
make download-gaussian-models  # Download 3D Gaussian models
make download-tts-models      # Download TTS models
make verify-models           # Verify all models
make backup-models           # Backup current models
make update-models           # Update to latest models
```

## Deployment

### Using Docker Compose

1. Build production images:
```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml build
```

2. Start production stack:
```bash
docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

### Manual Deployment

1. Build services:
```bash
make build
```

2. Deploy:
```bash
make deploy
```

## Contributing

### Development Process
1. Fork repository
2. Create feature branch
3. Implement changes
4. Add tests
5. Create pull request

### Code Style
- Python: PEP 8 with Black formatting
- JavaScript: ESLint + Prettier
- Documentation: Google style

### Testing
- Unit tests required
- Integration tests for features
- Performance benchmarks

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Citation

```bibtex
@misc{openphoenix2024,
  author = {OpenPhoenix Contributors},
  title = {OpenPhoenix-Live: Real-time Talking Head Generation},
  year = {2024},
  publisher = {GitHub},
  url = {https://github.com/bytjn1416124/open-phoenix-live}
}
```

## Disclaimer

This is a research and experimental project. Please note:
- Performance depends heavily on hardware capabilities
- The system requires significant computational resources
- Always respect privacy and ethical guidelines when handling facial data

## Support

- Issues: GitHub Issues
- Documentation: [Wiki](../../wiki)
- Community: [Discord](#)
- Email: [contact@example.com](#)