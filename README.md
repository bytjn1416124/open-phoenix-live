# OpenPhoenix-Live: Real-Time Interactive Video Chat with AI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/downloads/)
[![Node Version](https://img.shields.io/badge/node-16%2B-green)](https://nodejs.org/)
[![Docker](https://img.shields.io/badge/docker-required-blue)](https://www.docker.com/)

## Overview

OpenPhoenix-Live is an open-source system for creating interactive AI agents with real-time video conversation capabilities. Using 3D Gaussian Splatting and advanced neural networks, it enables natural face-to-face interactions with AI.

### Key Features

- **Real-time Video Processing**: WebRTC-based video streaming
- **Speech Recognition**: Live speech-to-text conversion
- **Natural Language Understanding**: LLM-powered conversation
- **Speech Synthesis**: High-quality text-to-speech
- **Facial Animation**: Real-time lip sync and expressions
- **3D Rendering**: Gaussian Splatting video generation

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
│   └── animation/          # Animation code
├── client/                 # Frontend
│   ├── public/             # Static assets
│   └── src/                # React code
└── models/                 # Pre-trained models
    ├── 3d_gs/              # Gaussian Splatting
    └── tts/                # TTS checkpoints
```

## Architecture

### Microservices Overview

The system uses a microservices architecture with Docker containers:

1. **Speech-to-Text Service (Port 5000)**
   - Real-time speech recognition
   - Audio stream processing
   - Uses Vosk for offline recognition
   - Configurable language models

2. **Language Model Service (Port 5001)**
   - Conversation management
   - Context handling
   - Response generation
   - Model API integration

3. **Text-to-Speech Service (Port 5002)**
   - Speech synthesis
   - Voice customization
   - Audio streaming
   - Expression control

4. **3D Rendering Service (Port 5003)**
   - Gaussian Splatting rendering
   - Real-time animation
   - GPU acceleration
   - Face model management

### Docker Configuration

#### Service Containers

1. **STT Container (Dockerfile.stt)**
   ```dockerfile
   # Base: Python 3.8-slim
   # Features:
   - Audio processing libs
   - FFmpeg integration
   - Vosk model support
   - Real-time streaming
   ```

2. **LLM Container (Dockerfile.llm)**
   ```dockerfile
   # Base: Python 3.8-slim
   # Features:
   - Lightweight deployment
   - API integrations
   - Memory optimization
   - State management
   ```

3. **TTS Container (Dockerfile.tts)**
   ```dockerfile
   # Base: Python 3.8-slim
   # Features:
   - Audio synthesis
   - Voice model handling
   - Stream processing
   - Expression markers
   ```

4. **Render Container (Dockerfile.render)**
   ```dockerfile
   # Base: nvidia/cuda:11.8.0
   # Features:
   - CUDA support
   - 3D graphics libs
   - GPU optimization
   - Real-time processing
   ```

#### Docker Compose Configuration

```yaml
# Key Features:
- Service orchestration
- GPU passthrough
- Volume management
- Network setup
- Resource limits
- Environment configs
```

## Prerequisites

### Hardware Requirements

- CUDA-capable GPU (6GB+ VRAM)
- CPU: 4+ cores
- RAM: 16GB+
- Storage: 20GB+
- Webcam & Microphone

### Software Requirements

- Docker & Docker Compose
- NVIDIA Container Toolkit
- CUDA Toolkit 11.8
- Git LFS

## Installation

### Quick Start (Docker)

1. Clone repository:
```bash
git clone https://github.com/bytjn1416124/open-phoenix-live.git
cd open-phoenix-live
```

2. Configure environment:
```bash
cp .env.example .env
# Edit .env with your settings
```

3. Start services:
```bash
docker-compose up -d
```

### Manual Setup

1. Environment setup:
```bash
make setup
make download-models
```

2. Start development:
```bash
make dev
```

## Development

### Docker Commands

1. Build services:
```bash
# Build all
docker-compose build

# Build specific service
docker-compose build stt
docker-compose build llm
docker-compose build tts
docker-compose build render
```

2. Service management:
```bash
# Start specific services
docker-compose up stt llm

# View logs
docker-compose logs -f [service_name]

# Scale services
docker-compose up -d --scale stt=2
```

3. Cleanup:
```bash
# Stop services
docker-compose down

# Remove volumes
docker-compose down -v

# Full cleanup
docker-compose down -v --rmi all
```

### Development Workflow

1. Service Development:
```bash
# Run single service
docker-compose up [service_name]

# Rebuild after changes
docker-compose up --build [service_name]
```

2. Testing:
```bash
# Run tests
make test

# Test specific service
docker-compose run stt pytest
```

3. Monitoring:
```bash
# CPU/Memory usage
docker stats

# GPU stats
nvidia-smi
```

## Production Deployment

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

1. Fork repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Create Pull Request

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