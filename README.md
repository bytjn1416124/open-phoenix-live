# OpenPhoenix-Live: Real-Time Interactive Video Chat with AI

[Previous sections remain the same...]

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
    ├── stt/                # Speech-to-Text models
    │   ├── vosk-model-small-en-us/  # Vosk model
    │   └── config.json     # Model configuration
    └── tts/                # TTS checkpoints
        ├── coqui_model.pth # TTS model weights
        └── config.json     # Model configuration
```

## Models

### Speech-to-Text Models

#### Configuration (config.json)
```json
{
  "model": {
    "name": "vosk",
    "version": "0.3.32",
    "type": "small",
    "language": "en-US",
    "architecture": {
      "type": "deepspeech",
      "sample_rate": 16000,
      "frame_size": 512,
      "hop_length": 160
    }
  },
  "features": {
    "noise_reduction": true,
    "vad": true,
    "streaming": true
  }
}
```

[Rest of the README remains the same...]
