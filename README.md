# OpenPhoenix-Live: Real-Time Conversational Video Interface

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/downloads/)
[![Node Version](https://img.shields.io/badge/node-16%2B-green)](https://nodejs.org/)

## Overview

OpenPhoenix-Live is an open-source implementation of a real-time talking-head generation system using 3D Gaussian Splatting. It enables the creation of interactive AI agents that can see, hear, and speak, simulating natural video conversations.

### Key Features

- **Real-time Video Processing**: WebRTC-based video streaming and processing
- **Speech Recognition**: Live speech-to-text conversion
- **Natural Language Understanding**: LLM-powered conversation management
- **Speech Synthesis**: High-quality text-to-speech generation
- **Facial Animation**: Real-time lip sync and expression control
- **3D Rendering**: Advanced 3D Gaussian Splatting rendering

## System Architecture

The system consists of seven major components:

1. **User Input Processing**
   - WebRTC video/audio capture
   - Real-time speech recognition
   - Input validation and preprocessing

2. **Conversation Management**
   - LLM-based dialogue system
   - Context management
   - Response generation

3. **Speech Synthesis**
   - Text-to-speech conversion
   - Voice customization
   - Emotion-aware speech generation

4. **Facial Animation**
   - Audio-driven lip sync
   - Expression synthesis
   - Blendshape control

5. **3D Rendering**
   - 3D Gaussian Splatting
   - Real-time view synthesis
   - Lighting and shading

6. **Web Interface**
   - React-based frontend
   - Real-time video display
   - Chat interface

7. **System Orchestration**
   - Microservices coordination
   - WebSocket communication
   - Resource management

## Prerequisites

### Hardware Requirements

- CUDA-capable GPU (minimum 6GB VRAM recommended)
- CPU with 4+ cores
- 16GB+ RAM
- Webcam and microphone for video input

### Software Requirements

- Python 3.8 or higher
- Node.js 16 or higher
- CUDA Toolkit 11.8
- Docker and Docker Compose
- Git LFS for model management

## Installation

### 1. Clone the Repository

```bash
git clone https://github.com/bytjn1416124/open-phoenix-live.git
cd open-phoenix-live
```

### 2. Environment Setup

```bash
# Create and activate virtual environment
make setup

# Download pre-trained models
make download-models
```

### 3. Configuration

Copy the example environment file and modify as needed:
```bash
cp .env.example .env
# Edit .env with your configuration
```

Key configuration options:
- `CUDA_VISIBLE_DEVICES`: GPU device selection
- `SERVER_PORT`: Main server port
- `OPENAI_API_KEY`: If using OpenAI's API

## Usage

### Development Mode

```bash
# Start all services in development mode
make dev
```

This will start:
- Backend server on port 8000
- Frontend development server on port 3000
- Individual microservices on their respective ports

### Production Deployment

```bash
# Build and deploy using Docker
make deploy
```

## Development

### Project Structure

```
open-phoenix-live/
├── server/                     # Backend implementation
│   ├── main_server.py         # Main server orchestration
│   ├── stt_service.py         # Speech-to-text service
│   ├── llm_service.py         # Language model service
│   ├── tts_service.py         # Text-to-speech service
│   ├── rendering_service.py   # 3D rendering service
│   └── animation/             # Animation related code
├── client/                    # Frontend implementation
│   ├── src/                   # React source code
│   └── public/                # Static assets
└── models/                    # Pre-trained models
    ├── stt/                   # Speech recognition models
    ├── tts/                   # Speech synthesis models
    └── 3d_gs/                 # 3D Gaussian Splatting models
```

### Available Commands

```bash
# Development
make dev              # Start development servers
make test             # Run all tests
make lint             # Run code quality checks
make format           # Format code

# Maintenance
make clean            # Clean up generated files
make clean-all        # Deep clean including dependencies

# Deployment
make deploy           # Deploy application
make build            # Build for production
```

## Testing

```bash
# Run all tests
make test

# Run specific test suites
make test-unit
make test-integration
```

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -am 'Add my feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Submit a pull request

### Code Style

- Python: Follow PEP 8 guidelines, enforced by black and flake8
- JavaScript: ESLint with Prettier for formatting
- Commit messages: Follow conventional commits format

## Troubleshooting

### Common Issues

1. **GPU Memory Issues**
   - Reduce batch size in `config.yml`
   - Monitor GPU memory usage with `nvidia-smi`

2. **WebRTC Connection Problems**
   - Check STUN/TURN server configuration
   - Verify browser permissions

3. **Model Loading Errors**
   - Ensure models are downloaded correctly
   - Check CUDA compatibility

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Citation

If you use this project in your research, please cite:

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
- Real-time performance depends heavily on hardware capabilities
- The system requires significant computational resources
- Always respect privacy and ethical guidelines when handling facial data

## Contact

For questions and support:
- Create an issue in the GitHub repository
- Join our [Discord community](#)
- Email: [contact@example.com](#)
