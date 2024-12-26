# OpenPhoenix-Live: Real-Time Interactive Video Chat with AI

[Earlier sections remain the same...]

## System Dependencies and Error Handling

### Required Software
```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install -y \
    python3-pip \
    python3-dev \
    build-essential \
    libsndfile1 \
    ffmpeg \
    nvidia-cuda-toolkit
```

### Service Dependencies
- STT Service → Vosk model
- TTS Service → Coqui model
- Rendering Service → 3D Gaussian model
- All services → Redis cache
- Frontend → WebRTC/WebSocket

## Error Handling

### 1. Model Loading
```python
try:
    stt_service = STTService()
    tts_service = TTSService()
    render_service = RenderingService()
except ModelNotFoundError:
    logger.error("Required models not found")
except GPUNotFoundError:
    logger.error("CUDA GPU not available")
```

### 2. Service Connections
```python
try:
    await service.connect()
except ConnectionError:
    await service.reconnect_with_backoff()
```

### 3. Real-time Processing
```python
try:
    result = await process_frame(data)
except TimeoutError:
    result = await fallback_process(data)
```

## Troubleshooting

### Common Issues

1. **Model Loading Fails**
   - Check model files exist
   - Verify CUDA installation
   - Check GPU memory

2. **Service Connection Issues**
   - Check network connectivity
   - Verify service ports
   - Check Docker containers

3. **Performance Issues**
   - Monitor GPU memory
   - Check CPU usage
   - Verify network bandwidth

### Quick Fixes

```bash
# Verify model files
make verify-models

# Restart services
docker-compose restart

# Check logs
docker-compose logs -f
```

### System Recovery

```bash
# Full system restart
make clean
make setup
make dev

# Individual service restart
docker-compose restart [service_name]
```

## Component Relationships

### Service Flow
```
User Browser → WebRTC → cvi_app.js → WebSocket → main_server.py
   ↓                                                    ↓
Video/Audio → STT Service → LLM Service → TTS Service → Render Service
   ↓            ↓             ↓            ↓              ↓
   Models →   STT Model      LLM         TTS Model    3D Model
```

[Rest of README remains the same...]
