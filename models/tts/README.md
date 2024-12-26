# Text-to-Speech Models

## Overview
This directory contains models for high-quality speech synthesis using Coqui TTS.

## Model Files

### coqui_model.pth
- **Purpose**: TTS synthesis model weights
- **Size**: ~250MB
- **Format**: PyTorch model file
- **Architecture**: FastSpeech2 + HiFiGAN

### config.json
```json
{
  "model": {
    "name": "fast_speech2",
    "version": "2.0.0",
    "architecture": {
      "encoder_layers": 4,
      "decoder_layers": 4,
      "hidden_size": 256,
      "duration_predictor": true,
      "pitch_predictor": true,
      "energy_predictor": true
    }
  },
  "vocoder": {
    "name": "hifigan",
    "version": "1.0.0",
    "config": {
      "resblock": "1",
      "upsample_rates": [8, 8, 2, 2],
      "upsample_kernel_sizes": [16, 16, 4, 4],
      "upsample_initial_channel": 512
    }
  },
  "audio": {
    "sample_rate": 22050,
    "hop_length": 256,
    "win_length": 1024,
    "n_mel_channels": 80,
    "mel_fmin": 0.0,
    "mel_fmax": 8000.0
  },
  "training": {
    "batch_size": 32,
    "learning_rate": 0.001,
    "epochs": 1000,
    "save_interval": 10000
  },
  "voices": {
    "enabled": ["female_1", "male_1"],
    "female_1": {
      "name": "Emma",
      "language": "en",
      "accent": "american"
    },
    "male_1": {
      "name": "James",
      "language": "en",
      "accent": "british"
    }
  },
  "features": {
    "emotion_control": true,
    "speed_control": true,
    "pitch_control": true,
    "energy_control": true
  }
}
```

## Usage

### Loading the Model
```python
from server.tts_service import TTSService

tts = TTSService(
    model_path="models/tts/coqui_model.pth",
    config_path="models/tts/config.json"
)
```

### Voice Selection
```python
# Use specific voice
await tts.synthesize(text, voice_id="female_1")

# List available voices
voices = tts.get_available_voices()
```

### Performance Requirements
- CPU: 4+ cores
- RAM: 8GB+
- GPU: Optional but recommended

## Model Details

### Architecture
- FastSpeech2 for acoustic modeling
- HiFiGAN for waveform generation
- Multi-speaker support

### Audio Specifications
- Sample Rate: 22050 Hz
- Mel Channels: 80
- Frequency Range: 0-8000 Hz

### Features
- Real-time synthesis
- Voice selection
- Emotion control
- Speed adjustment
- Pitch modification

## Training Data
Trained on:
- LJSpeech dataset
- Additional proprietary recordings
- Multi-speaker corpora