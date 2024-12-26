# 3D Gaussian Splatting Models

## Overview
This directory contains models for real-time 3D face rendering using Gaussian Splatting.

## Model Files

### pretrained_model.pth
- **Purpose**: Main model weights for 3D Gaussian Splatting
- **Size**: ~500MB
- **Format**: PyTorch model file
- **Architecture**: Custom Gaussian Splatting network

### config.yaml
```yaml
model:
  type: gaussian_splatting
  version: "1.0"
  features:
    gaussian_count: 100000
    feature_dim: 256
    position_dim: 3
    scale_dim: 3
    rotation_dim: 4

rendering:
  resolution:
    width: 640
    height: 480
  fps: 30
  quality: high
  cuda:
    required: true
    min_memory: "6GB"

animation:
  deformation:
    enabled: true
    blendshapes: 52
    smoothing: true
  expressions:
    enabled: true
    types:
      - neutral
      - smile
      - talk
      - surprise

optimization:
  batch_size: 4096
  parallel_points: 65536
  culling:
    enabled: true
    distance: 0.01
```

## Usage

### Loading the Model
```python
from server.rendering_service import GaussianSplattingRenderer

renderer = GaussianSplattingRenderer(
    model_path="models/3d_gs/pretrained_model.pth",
    config_path="models/3d_gs/config.yaml"
)
```

### Performance Requirements
- CUDA-capable GPU (6GB+ VRAM)
- CUDA Toolkit 11.8+
- 16GB+ System RAM

## Model Details

### Gaussian Parameters
- Number of Gaussians: 100,000
- Feature Dimension: 256
- Position/Scale/Rotation encoding

### Rendering Capabilities
- Real-time view synthesis
- Expression deformation
- Dynamic lighting
- Occlusion handling

### Expression Control
- 52 blendshape parameters
- Smooth interpolation
- Real-time updates

## Training Data
The model was trained on:
- High-quality face scans
- Multi-view video sequences
- Expression datasets