import logging
import os
from functools import wraps
from typing import Optional, Callable, Any
from ..exceptions import *

logger = logging.getLogger(__name__)

def handle_service_errors(retries: int = 3, backup_handler: Optional[Callable] = None):
    """Decorator for handling service errors with retries."""
    def decorator(func):
        @wraps(func)
        async def wrapper(*args, **kwargs):
            last_error = None
            for attempt in range(retries):
                try:
                    return await func(*args, **kwargs)
                except ModelError as e:
                    logger.error(f"Model error: {e}")
                    if backup_handler:
                        return await backup_handler(*args, **kwargs)
                    raise
                except GPUError as e:
                    logger.error(f"GPU error: {e}")
                    if attempt == retries - 1:
                        if backup_handler:
                            return await backup_handler(*args, **kwargs)
                        raise
                except ProcessingError as e:
                    logger.warning(f"Processing error (attempt {attempt + 1}/{retries}): {e}")
                    last_error = e
                    continue
                except Exception as e:
                    logger.error(f"Unexpected error: {e}")
                    raise
            
            if last_error:
                raise last_error
        return wrapper
    return decorator

def validate_model_path(path: str) -> None:
    """Validate that a model file exists."""
    if not os.path.exists(path):
        raise ModelNotFoundError(f"Model not found at {path}")

def check_gpu():
    """Check GPU availability and memory."""
    import torch
    if not torch.cuda.is_available():
        raise GPUNotFoundError("CUDA GPU not available")
    
    # Check GPU memory
    gpu = torch.cuda.get_device_properties(0)
    if gpu.total_memory / (1024**3) < 6:  # Less than 6GB
        raise GPUMemoryError(f"Insufficient GPU memory: {gpu.total_memory / (1024**3):.1f}GB")

def log_error(error: Exception, service_name: str) -> None:
    """Log error with service context."""
    logger.error(f"[{service_name}] {str(error)}", exc_info=True)

def cleanup_service(service: Any) -> None:
    """Clean up service resources."""
    try:
        if hasattr(service, 'cleanup'):
            service.cleanup()
    except Exception as e:
        logger.error(f"Error during cleanup: {e}")
