import asyncio
import logging
from typing import Optional
import numpy as np
from vosk import Model, KaldiRecognizer, SetLogLevel

logger = logging.getLogger(__name__)

class STTService:
    def __init__(self, model_path: str = "models/stt/vosk-model-small-en-us"):
        """Initialize Speech-to-Text service.
        
        Args:
            model_path (str): Path to Vosk model directory
        """
        try:
            SetLogLevel(-1)  # Reduce Vosk logging noise
            self.model = Model(model_path)
            self.recognizer = KaldiRecognizer(self.model, 16000)
            self.recognizer.SetWords(True)
            logger.info("STT Service initialized successfully")
            
        except Exception as e:
            logger.error(f"Failed to initialize STT service: {e}")
            raise

    async def process_audio(self, audio_data: bytes) -> Optional[str]:
        """Process audio data and return transcribed text.
        
        Args:
            audio_data (bytes): Raw audio data
            
        Returns:
            Optional[str]: Transcribed text if successful, None otherwise
        """
        try:
            if not audio_data:
                return None

            # Convert audio bytes to numpy array
            audio_array = np.frombuffer(audio_data, dtype=np.int16)
            
            # Process chunks of audio
            chunk_size = 4096
            transcribed_text = ""
            
            for i in range(0, len(audio_array), chunk_size):
                chunk = audio_array[i:i + chunk_size].tobytes()
                if self.recognizer.AcceptWaveform(chunk):
                    result = self.recognizer.Result()
                    transcribed_text += result + " "
            
            # Get final result
            final_result = self.recognizer.FinalResult()
            if final_result:
                transcribed_text += final_result

            # Clean up the text
            transcribed_text = " ".join(transcribed_text.split())
            
            if transcribed_text:
                logger.debug(f"Transcribed text: {transcribed_text}")
                return transcribed_text
            return None

        except Exception as e:
            logger.error(f"Error in STT processing: {e}")
            return None

    def reset(self):
        """Reset the recognizer state."""
        self.recognizer = KaldiRecognizer(self.model, 16000)
        self.recognizer.SetWords(True)