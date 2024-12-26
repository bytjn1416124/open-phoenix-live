# Speech-to-Text Models

## Overview
This directory contains models for real-time speech recognition using Vosk.

## Model Files

### vosk-model-small-en-us
- **Purpose**: Real-time speech recognition
- **Size**: ~50MB
- **Format**: Vosk model format
- **Language**: English (US)

### config.json
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
  },
  "performance": {
    "real_time_factor": 0.5,
    "max_audio_duration": 60,
    "cpu_threads": 4
  }
}
```

## Usage

### Loading the Model
```python
from server.stt_service import STTService

stt = STTService(
    model_path="models/stt/vosk-model-small-en-us",
    config_path="models/stt/config.json"
)
```

### Performance Requirements
- CPU: 2+ cores
- RAM: 4GB+
- Disk: 200MB

## Model Details

### Features
- Real-time transcription
- Noise reduction
- Voice activity detection
- Streaming support

### Languages
- Primary: English (US)
- Model can be replaced with other language models

### Performance
- Real-time factor: 0.5x
- Latency: <100ms
- Accuracy: ~90% (WER)

## Training Data
Trained on:
- LibriSpeech dataset
- Common Voice
- Custom audio corpora