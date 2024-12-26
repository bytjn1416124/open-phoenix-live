import asyncio
import logging
import numpy as np
import torch
from typing import AsyncGenerator, Optional, Dict, Any
from pathlib import Path
from .exceptions import *
from .utils.error_handler import handle_service_errors, validate_model_path, check_gpu
from .animation.real_time_drivers import FacialAnimationDriver

logger = logging.getLogger(__name__)

class RenderingService:
    def __init__(self,
                 model_path: Optional[str] = None,
                 config_path: Optional[str] = None,
                 frame_rate: int = 30,
                 resolution: tuple = (640, 480)):
        """Initialize the 3D rendering service.

        Args:
            model_path: Path to 3D Gaussian Splatting model
            config_path: Path to configuration file
            frame_rate: Target frame rate
            resolution: Output resolution (width, height)

        Raises:
            ModelNotFoundError: If model files not found
            ModelLoadError: If model initialization fails
            GPUError: If GPU initialization or memory check fails
        """
        try:
            self.model_path = model_path or "models/3d_gs/pretrained_model.pth"
            self.config_path = config_path or "models/3d_gs/config.yaml"
            
            # Validate paths
            validate_model_path(self.model_path)
            validate_model_path(self.config_path)
            
            # Check GPU availability and memory
            check_gpu()
            
            # Initialize parameters
            self.frame_rate = frame_rate
            self.resolution = resolution
            self.frame_time = 1.0 / frame_rate
            
            # Initialize components
            self.device = torch.device('cuda')
            self.animation_driver = FacialAnimationDriver()
            self._initialize_renderer()
            
            logger.info("Rendering Service initialized successfully")
            
        except Exception as e:
            logger.error(f"Failed to initialize rendering service: {str(e)}")
            raise ModelLoadError(f"Rendering service initialization failed: {str(e)}") from e

    def _initialize_renderer(self) -> None:
        """Initialize the Gaussian Splatting renderer.

        Raises:
            ModelLoadError: If renderer initialization fails
            GPUMemoryError: If insufficient GPU memory
        """
        try:
            # Load model weights
            checkpoint = torch.load(self.model_path, map_location=self.device)
            
            # Initialize renderer components
            self.gaussians = checkpoint['gaussians'].to(self.device)
            self.colors = checkpoint['colors'].to(self.device)
            self.opacities = checkpoint['opacities'].to(self.device)
            
            # Verify GPU memory
            available_memory = torch.cuda.get_device_properties(0).total_memory
            required_memory = sum(tensor.nelement() * tensor.element_size() 
                                for tensor in [self.gaussians, self.colors, self.opacities])
            
            if required_memory > available_memory * 0.9:  # 90% threshold
                raise GPUMemoryError("Insufficient GPU memory for model")
                
        except Exception as e:
            logger.error(f"Failed to initialize renderer: {str(e)}")
            raise ModelLoadError(f"Renderer initialization failed: {str(e)}") from e

    @handle_service_errors(retries=2)
    async def render_frames(self, audio_data: bytes) -> AsyncGenerator[bytes, None]:
        """Generate video frames based on audio input.

        Args:
            audio_data: Raw audio data for lip sync

        Yields:
            bytes: Rendered frame data

        Raises:
            ProcessingError: If frame generation fails
            GPUMemoryError: If GPU memory is exceeded
        """
        try:
            # Convert audio to numpy array
            audio_array = np.frombuffer(audio_data, dtype=np.int16)
            
            # Get facial expressions from audio
            expressions = self.animation_driver.process_audio(audio_array)
            
            # Calculate timing
            audio_duration = len(audio_array) / 16000  # Assuming 16kHz audio
            total_frames = int(audio_duration * self.frame_rate)
            
            frame_start_time = asyncio.get_event_loop().time()
            
            for frame_idx in range(total_frames):
                try:
                    # Get current expression
                    current_expression = expressions[min(frame_idx, len(expressions) - 1)]
                    
                    # Render frame
                    frame = await self._render_single_frame(current_expression)
                    
                    # Convert to bytes
                    frame_data = frame.tobytes()
                    
                    # Maintain frame rate
                    target_time = frame_start_time + (frame_idx + 1) * self.frame_time
                    current_time = asyncio.get_event_loop().time()
                    if current_time < target_time:
                        await asyncio.sleep(target_time - current_time)
                    
                    yield frame_data
                    
                except Exception as e:
                    logger.error(f"Error rendering frame {frame_idx}: {str(e)}")
                    raise ProcessingError(f"Frame generation failed: {str(e)}") from e
                    
        except Exception as e:
            logger.error(f"Error in render_frames: {str(e)}")
            raise

    async def _render_single_frame(self, expression_params: Dict[str, float]) -> np.ndarray:
        """Render a single frame with the given expression parameters.

        Args:
            expression_params: Facial expression parameters

        Returns:
            np.ndarray: Rendered frame

        Raises:
            ProcessingError: If rendering fails
            GPUMemoryError: If GPU memory is exceeded
        """
        try:
            with torch.cuda.amp.autocast():  # Use automatic mixed precision
                # Apply expression deformation
                deformed_gaussians = self._apply_expression(expression_params)
                
                # Project gaussians to screen space
                projected = self._project_gaussians(deformed_gaussians)
                
                # Render frame
                frame = self._render_gaussians(projected)
                
                return frame.cpu().numpy()
                
        except torch.cuda.OutOfMemoryError:
            torch.cuda.empty_cache()
            raise GPUMemoryError("GPU memory exceeded during rendering")
            
        except Exception as e:
            logger.error(f"Error in single frame rendering: {str(e)}")
            raise ProcessingError(f"Frame rendering failed: {str(e)}") from e

    async def cleanup(self) -> None:
        """Clean up GPU resources."""
        try:
            # Clear CUDA cache
            torch.cuda.empty_cache()
            
            # Reset variables
            self.gaussians = None
            self.colors = None
            self.opacities = None
            
            logger.info("Rendering service cleaned up successfully")
            
        except Exception as e:
            logger.error(f"Error during cleanup: {str(e)}")

    async def reset(self) -> None:
        """Reset the service state."""
        try:
            await self.cleanup()
            self._initialize_renderer()
            logger.info("Rendering service reset successfully")
            
        except Exception as e:
            logger.error(f"Error resetting rendering service: {str(e)}")
            raise