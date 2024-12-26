# OpenPhoenix-Live Server Components

## Overview
Server-side implementation of the OpenPhoenix-Live system.

## Directory Structure
```plaintext
server/
├── main_server.py      # Main orchestration
├── stt_service.py      # Speech recognition
├── llm_service.py      # Language model
├── tts_service.py      # Speech synthesis
├── rendering_service.py # 3D rendering
├── animation/          # Animation code
│   └── real_time_drivers.py  # Real-time animation
└── utils/              # Utility functions
```

## Services

### main_server.py
- WebSocket server implementation
- Service orchestration
- Client communication

### stt_service.py
- Real-time speech recognition
- Audio stream processing
- Language detection

### llm_service.py
- Conversation management
- Natural language processing
- Response generation

### tts_service.py
- Text-to-speech conversion
- Voice synthesis
- Audio streaming

### rendering_service.py
- 3D Gaussian Splatting
- Real-time animation
- Frame generation

## Dependencies
- Python 3.8+
- CUDA Toolkit 11.8
- PyTorch 2.0+
- FastAPI

## Setup
```bash
# Install dependencies
pip install -r requirements.txt

# Start server
python main_server.py
```