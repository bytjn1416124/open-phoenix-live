import asyncio
import logging
import numpy as np
from typing import Optional
from vosk import Model, KaldiRecognizer, SetLogLevel
from .exceptions import *
from .utils.error_handler import handle_service_errors, validate_model_path

logger = logging.getLogger(__name__)

class STTService:
    def __init__(self, model_path: str = "models/stt/vosk-model-small-en-us", sample_rate: int = 16000):
        """Initialize Speech-to-Text service.

        Args:
            model_path (str): Path to Vosk model directory
            sample_rate (int): Audio sample rate in Hz

        Raises:
            ModelNotFoundError: If model files not found
            ModelLoadError: If model initialization fails
        """
        try:
            validate_model_path(model_path)
            SetLogLevel(-1)  # Reduce Vosk logging noise
            
            self.model = Model(model_path)
            self.sample_rate = sample_rate
            self.min_audio_length = int(0.1 * sample_rate)  # 100ms minimum
            self.recognizer = None
            self._initialize_recognizer()
            
            logger.info("STT Service initialized successfully")
            
        except Exception as e:
            raise ModelLoadError(f"Failed to initialize STT service: {str(e)}") from e

    def _initialize_recognizer(self) -> None:
        """Initialize or reinitialize the speech recognizer."""
        try:
            self.recognizer = KaldiRecognizer(self.model, self.sample_rate)
            self.recognizer.SetWords(True)
        except Exception as e:
            raise ModelLoadError(f"Failed to initialize recognizer: {str(e)}") from e

    @handle_service_errors(retries=3)
    async def process_audio(self, audio_data: bytes) -> Optional[str]:
        """Process audio data and return transcribed text.

        Args:
            audio_data (bytes): Raw audio data

        Returns:
            Optional[str]: Transcribed text if successful, None otherwise

        Raises:
            ProcessingError: If audio processing fails
        """
        try:
            if not audio_data:
                logger.warning("Received empty audio data")
                return None

            # Convert audio bytes to numpy array
            audio_array = np.frombuffer(audio_data, dtype=np.int16)
            
            # Validate audio length
            if len(audio_array) < self.min_audio_length:
                logger.debug("Audio chunk too short")
                return None

            # Process audio in chunks
            chunk_size = 4096
            text_results = []
            
            for i in range(0, len(audio_array), chunk_size):
                chunk = audio_array[i:i + chunk_size].tobytes()
                
                if self.recognizer.AcceptWaveform(chunk):
                    result = self.recognizer.Result()
                    if result and result.strip():
                        text_results.append(result)

            # Get final result
            final_result = self.recognizer.FinalResult()
            if final_result and final_result.strip():
                text_results.append(final_result)

            # Combine and clean results
            if text_results:
                combined_text = ' '.join(text_results)
                return ' '.join(combined_text.split())  # Clean extra whitespace
            
            return None

        except Exception as e:
            logger.error(f"Error in audio processing: {str(e)}")
            raise ProcessingError(f"Failed to process audio: {str(e)}") from e

    async def cleanup(self) -> None:
        """Clean up resources."""
        try:
            self.recognizer = None  # Release recognizer
            # Additional cleanup if needed
        except Exception as e:
            logger.error(f"Error during cleanup: {str(e)}")

    async def reset(self) -> None:
        """Reset the service state."""
        try:
            self._initialize_recognizer()
            logger.info("STT Service reset successfully")
        except Exception as e:
            logger.error(f"Error resetting STT service: {str(e)}")
            raise
