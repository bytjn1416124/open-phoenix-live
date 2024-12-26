# OpenPhoenix-Live Docker Configuration

## Overview
Docker configuration files for running OpenPhoenix-Live services.

## Directory Structure
```plaintext
docker/
├── Dockerfile.stt      # Speech-to-Text service
├── Dockerfile.llm      # Language Model service
├── Dockerfile.tts      # Text-to-Speech service
├── Dockerfile.render   # 3D Rendering service
└── docker-compose.yml  # Service orchestration
```

## Services

### STT Service (Dockerfile.stt)
- Base: Python 3.8-slim
- Port: 5000
- Features:
  - Speech recognition
  - Audio processing

### LLM Service (Dockerfile.llm)
- Base: Python 3.8-slim
- Port: 5001
- Features:
  - Language processing
  - Response generation

### TTS Service (Dockerfile.tts)
- Base: Python 3.8-slim
- Port: 5002
- Features:
  - Speech synthesis
  - Audio streaming

### Render Service (Dockerfile.render)
- Base: nvidia/cuda:11.8.0
- Port: 5003
- Features:
  - 3D rendering
  - GPU acceleration

## Usage
```bash
# Build images
docker-compose build

# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```