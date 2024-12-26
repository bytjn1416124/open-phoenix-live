# 3D Gaussian Splatting Models

## Overview
These models handle real-time 3D face representation and rendering using Gaussian Splatting techniques.

## Files

### pretrained_model.pth
- Size: ~5GB
- Format: PyTorch model checkpoint
- Purpose: Contains learned Gaussian parameters

Key components:
```python
model_structure = {
    'gaussians': {
        'means': [N, 3],       # 3D positions
        'scales': [N, 3],       # Scale parameters
        'rotations': [N, 4],    # Quaternion rotations
        'opacities': [N, 1],    # Opacity values
        'features': [N, D]      # Feature vectors
    },
    'deformation_net': {
        'weights': {...},       # Network parameters
        'config': {...}         # Architecture settings
    }
}
```

### config.yaml
```yaml
model:
  type: gaussian_splatting
  num_gaussians: 100000
  feature_dim: 32
  rendering:
    resolution: [640, 480]
    fps: 30
    max_depth: 1000.0
    min_depth: 0.1
    point_size: 1.5
  deformation:
    enabled: true
    hidden_dim: 256
    num_layers: 4
    activation: relu
  optimization:
    learning_rate: 0.001
    batch_size: 4096
    num_iterations: 10000
```

## Usage
```python
from rendering_service import GaussianRenderer

# Load model
renderer = GaussianRenderer('models/3d_gs/pretrained_model.pth')

# Render frame
frame = renderer.render_frame(
    camera_pose=camera_pose,
    expressions=expressions
)
```