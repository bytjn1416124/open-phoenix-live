# Text-to-Speech Models

## Overview
These models provide high-quality speech synthesis capabilities using the Coqui TTS framework.

## Files

### coqui_model.pth
- Size: ~2GB
- Format: PyTorch model checkpoint
- Purpose: Voice synthesis parameters

Model architecture:
```python
model_structure = {
    'encoder': {
        'type': 'Tacotron2',
        'layers': [...]
    },
    'decoder': {
        'type': 'HifiGAN',
        'layers': [...]
    },
    'vocoder': {
        'type': 'UnivNet',
        'config': {...}
    }
}
```

### config.json
```json
{
    "model": {
        "name": "coqui_tts",
        "version": "1.2.0",
        "sample_rate": 22050,
        "hop_length": 256,
        "win_length": 1024,
        "n_mel_channels": 80
    },
    "voices": {
        "default": {
            "language": "en",
            "gender": "female",
            "style": "neutral"
        }
    },
    "inference": {
        "batch_size": 32,
        "use_gpu": true,
        "chunk_size": 44100
    },
    "features": {
        "emotions": true,
        "speed_control": true,
        "pitch_control": true
    }
}
```

## Usage
```python
from tts_service import TTSGenerator

# Initialize TTS
tts = TTSGenerator('models/tts/coqui_model.pth')

# Generate speech
audio = tts.synthesize(
    text="Hello, how are you?",
    voice_id="default",
    emotion="happy"
)
```