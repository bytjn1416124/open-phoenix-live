# OpenPhoenix-Live: Real-Time Interactive Video Chat with AI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/downloads/)
[![Node Version](https://img.shields.io/badge/node-16%2B-green)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)
- [Error Handling](#error-handling)
- [Configuration](#configuration)
- [Docker Setup](#docker-setup)
- [Models](#models)
- [Contributing](#contributing)
- [License](#license)
- [Citation](#citation)

## Overview

OpenPhoenix-Live is an advanced open-source system for creating interactive AI video agents. Using 3D Gaussian Splatting and neural networks, it enables natural face-to-face video conversations with AI agents in real-time.

## Key Features

### Core Capabilities
- Real-time two-way video conversations
- Natural language understanding and generation
- Speech recognition and synthesis
- Expressive facial animations and lip syncing
- 3D face model rendering and manipulation

### Technical Features
- WebRTC-based video streaming
- GPU-accelerated 3D rendering
- Microservices architecture
- Docker containerization
- Real-time audio/video processing

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
├── models/                 # Pre-trained models
│   ├── 3d_gs/             # Pretrained Gaussians
│   │   ├── pretrained_model.pth  # Main model weights
│   │   └── config.yaml     # Model configuration
│   ├── stt/                # Speech-to-Text models
│   │   ├── vosk-model-small-en-us/  # Vosk model
│   │   └── config.json     # Model configuration
│   └── tts/                # TTS checkpoints
│       ├── coqui_model.pth # TTS model weights
│       └── config.json     # Model configuration
└── scripts/               # Utility scripts
```

## Prerequisites

### Hardware Requirements
- CUDA-capable GPU (minimum 6GB VRAM)
- CPU: 4+ cores
- RAM: 16GB+
- Storage: 20GB+
- Webcam and microphone

### Software Requirements
```bash
# System packages (Ubuntu/Debian)
sudo apt-get update && sudo apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    libsndfile1 \
    ffmpeg \
    nvidia-cuda-toolkit

# Python 3.8+
python3 --version

# Node.js 16+
node --version

# Docker & Docker Compose
docker --version
docker-compose --version

# NVIDIA Container Toolkit
nvidia-smi
```

## Installation

### 1. Clone Repository
```bash
git clone https://github.com/bytjn1416124/open-phoenix-live.git
cd open-phoenix-live
```

### 2. Environment Setup
```bash
# Setup environment
make setup

# Download models
make download-models
```

### 3. Configuration
```bash
# Create and edit environment variables
cp .env.example .env
```

## Usage

### Development Mode
```bash
# Start all services
make dev

# Start individual components
make client  # Frontend only
make server  # Backend only
```

### Production Mode
```bash
# Build and deploy with Docker
make deploy
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

# Models
make verify-models     # Verify model files
make backup-models     # Backup current models
make update-models     # Update to latest models
```

## Error Handling

### Common Issues

1. **Model Loading Errors**
```bash
# Verify model files
make verify-models

# Re-download models
make clean-models
make download-models
```

2. **GPU Memory Issues**
```bash
# Check GPU status
nvidia-smi

# Clean GPU memory
make clean
```

3. **Service Connection Issues**
```bash
# Check service status
docker-compose ps

# View logs
docker-compose logs -f [service_name]
```

## Configuration

### Environment Variables
```bash
# Server Configuration
SERVER_PORT=8000
DEBUG_MODE=false

# GPU Settings
CUDA_VISIBLE_DEVICES=0
NVIDIA_VISIBLE_DEVICES=all

# Model Paths
STT_MODEL_PATH=models/stt/vosk-model-small-en-us
TTS_MODEL_PATH=models/tts/coqui_model.pth
GAUSSIAN_MODEL_PATH=models/3d_gs/pretrained_model.pth
```

## Docker Setup

### Service Configuration
```yaml
# docker-compose.yml
services:
  main:
    build: ...
    ports: ["8000:8000"]
  stt:
    build: ...
    expose: ["5000"]
  llm:
    build: ...
    expose: ["5001"]
  tts:
    build: ...
    expose: ["5002"]
  render:
    build: ...
    runtime: nvidia
    expose: ["5003"]
```

## Models

### Required Models
1. **Speech-to-Text (STT)**
   - Vosk model for real-time speech recognition
   - Configuration in `models/stt/config.json`

2. **Text-to-Speech (TTS)**
   - Coqui TTS model for voice synthesis
   - Configuration in `models/tts/config.json`

3. **3D Gaussian Splatting**
   - Pretrained model for face rendering
   - Configuration in `models/3d_gs/config.yaml`

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

## Support

- Issues: GitHub Issues
- Documentation: [Wiki](../../wiki)
- Community: [Discord](#)
- Email: [contact@example.com](#)

## Disclaimer

This is a research and experimental project. Please note:
- Performance depends heavily on hardware capabilities
- The system requires significant computational resources
- Always respect privacy and ethical guidelines when handling facial data