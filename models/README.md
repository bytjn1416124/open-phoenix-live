# OpenPhoenix-Live Models

This directory contains all pre-trained models used by the OpenPhoenix-Live system.

## Directory Structure
```
models/
├── 3d_gs/              # 3D Gaussian Splatting models
│   ├── pretrained_model.pth  # Main model weights
│   └── config.yaml     # Model configuration
└── tts/                # Text-to-Speech models
    ├── coqui_model.pth # TTS model weights
    └── config.json     # Model configuration
```

## Model Management

### Download Models
```bash
# Download all models
make download-models

# Download specific models
make download-gaussian-models  # 3D Gaussian models only
make download-tts-models      # TTS models only
```

### Verify Models
```bash
make verify-models  # Check model integrity
```

### Model Updates
```bash
make update-models  # Update to latest versions
make backup-models  # Backup current models
```

## Model Details

For specific model information, see:
- [3D Gaussian Splatting Models](3d_gs/README.md)
- [Text-to-Speech Models](tts/README.md)