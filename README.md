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
│   ├── animation/          # Animation code
│   │   └── real_time_drivers.py  # Real-time animation drivers
│   └── utils/              # Utility functions
├── client/                 # Frontend
│   ├── public/             # Static assets
│   │   └── index.html      # Main HTML file
│   ├── src/                # React source code
│   └── components/         # React components
├── models/                 # Pre-trained models
│   ├── 3d_gs/              # Gaussian Splatting models
│   └── tts/                # TTS checkpoints
└── scripts/               # Utility scripts
    ├── setup.sh            # Setup script
    ├── dev.sh              # Development script
    └── deploy.sh           # Deployment script
```

[Rest of README content remains the same...]
