# OpenPhoenix-Live: Real-Time Interactive Video Chat with AI

[Previous badges and introduction remain the same...]

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
├── models/                 # Pre-trained models
│   ├── 3d_gs/             # Pretrained Gaussians
│   │   ├── pretrained_model.pth  # Main model weights
│   │   └── config.yaml     # Model configuration
│   └── tts/               # TTS checkpoints
│       ├── coqui_model.pth # TTS model weights
│       └── config.json     # Model configuration
└── scripts/               # Utility scripts
```

## Models

### 3D Gaussian Splatting Models

Located in `models/3d_gs/`, these models handle 3D face representation and rendering.

#### Required Files
- `pretrained_model.pth`: Main model weights
- `config.yaml`: Model configuration and parameters

#### Features
- Real-time 3D face rendering
- Expression deformation
- View synthesis
- Lighting adaptation

#### Model Details
```yaml
# config.yaml structure
model:
  type: gaussian_splatting
  features: 256
  num_gaussians: 100000
  viewport_size: [640, 480]
  rendering:
    fps: 30
    quality: high
```

### Text-to-Speech Models

Located in `models/tts/`, these models handle speech synthesis.

#### Required Files
- `coqui_model.pth`: TTS model weights
- `config.json`: Voice and synthesis parameters

#### Features
- High-quality speech synthesis
- Multiple voice support
- Emotion control
- Real-time generation

#### Model Details
```json
// config.json structure
{
  "model": {
    "type": "coqui_tts",
    "sample_rate": 22050,
    "voice_ids": ["voice_1", "voice_2"],
    "features": {
      "emotions": true,
      "speed_control": true
    }
  }
}
```

### Model Management

#### Download Models
```bash
# Download all models
make download-models

# Download specific models
make download-gaussian-models  # 3D Gaussian models only
make download-tts-models      # TTS models only
```

#### Verify Models
```bash
# Verify all model files
make verify-models
```

#### Model Updates
```bash
# Update to latest models
make update-models

# Backup existing models
make backup-models
```

[Rest of the README remains the same...]
