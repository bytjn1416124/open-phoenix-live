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
- [Installation](#installation)
- [Development](#development)
- [Deployment](#deployment)
- [Contributing](#contributing)

## Overview

OpenPhoenix-Live is an advanced open-source system for creating interactive AI agents with real-time video conversation capabilities. Utilizing 3D Gaussian Splatting and neural networks, it enables natural face-to-face interactions with AI.

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
    ├── 3d_gs/              # Gaussian Splatting models
    └── tts/                # TTS checkpoints
```

## Component Details

### Backend Services

#### 1. Speech-to-Text Service (stt_service.py)
- **Purpose**: Real-time speech recognition
- **Key Features**:
  - Streaming audio processing
  - Low-latency recognition
  - Multiple language support
  - Noise reduction
- **Dependencies**:
  - Vosk for offline recognition
  - FFmpeg for audio processing
  - WebSocket streaming support

#### 2. Language Model Service (llm_service.py)
- **Purpose**: Natural language understanding and generation
- **Key Features**:
  - Context management
  - State tracking
  - Response generation
  - Memory handling
- **Capabilities**:
  - Multi-turn conversations
  - Personality consistency
  - Context awareness
  - Error recovery

#### 3. Text-to-Speech Service (tts_service.py)
- **Purpose**: Speech synthesis
- **Key Features**:
  - High-quality voice synthesis
  - Emotional expression
  - Real-time generation
  - Voice customization
- **Outputs**:
  - Streaming audio
  - Expression markers
  - Timing information

#### 4. Rendering Service (rendering_service.py)
- **Purpose**: 3D face rendering
- **Key Features**:
  - 3D Gaussian Splatting
  - Real-time animation
  - Expression control
  - View synthesis
- **Components**:
  - GPU renderer
  - Animation system
  - Frame generator
  - Stream manager

### Animation System

#### Real-Time Drivers (real_time_drivers.py)
- **Purpose**: Animation control
- **Features**:
  - Lip sync generation
  - Expression blending
  - Motion smoothing
  - Timing control
- **Capabilities**:
  - Audio-driven animation
  - Expression mapping
  - Real-time updates
  - Performance optimization

### Frontend Components

#### 1. Main Application (cvi_app.js)
- **Purpose**: WebRTC and video management
- **Features**:
  - Video stream handling
  - WebSocket communication
  - UI state management
  - Real-time updates
- **Components**:
  - Video interface
  - Chat system
  - Controls
  - Status display

#### 2. React Components
- **Video Interface**:
  - Stream display
  - Camera control
  - Layout management
- **Chat Interface**:
  - Message history
  - Input handling
  - Status updates
- **Control Panel**:
  - Settings
  - Audio controls
  - Video options

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

# Cleanup
make clean             # Clean generated files
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
MIT License - see [LICENSE](LICENSE)

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