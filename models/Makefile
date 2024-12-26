# Makefile for model management

# Paths
GAUSSIAN_PATH = 3d_gs
TTS_PATH = tts

# Model URLs (placeholder - replace with actual URLs)
GAUSSIAN_URL = https://example.com/gaussian_model.zip
TTS_URL = https://example.com/tts_model.zip

.PHONY: all download verify clean backup update

all: download verify

# Download models
download:
	@echo "Downloading models..."
	@mkdir -p $(GAUSSIAN_PATH)
	@mkdir -p $(TTS_PATH)
	@echo "Downloading 3D Gaussian model..."
	@wget -q -O gaussian_temp.zip $(GAUSSIAN_URL)
	@unzip -q gaussian_temp.zip -d $(GAUSSIAN_PATH)
	@rm gaussian_temp.zip
	@echo "Downloading TTS model..."
	@wget -q -O tts_temp.zip $(TTS_URL)
	@unzip -q tts_temp.zip -d $(TTS_PATH)
	@rm tts_temp.zip

# Verify model integrity
verify:
	@echo "Verifying models..."
	@test -f $(GAUSSIAN_PATH)/pretrained_model.pth || (echo "Missing Gaussian model"; exit 1)
	@test -f $(GAUSSIAN_PATH)/config.yaml || (echo "Missing Gaussian config"; exit 1)
	@test -f $(TTS_PATH)/coqui_model.pth || (echo "Missing TTS model"; exit 1)
	@test -f $(TTS_PATH)/config.json || (echo "Missing TTS config"; exit 1)
	@echo "All models verified successfully"

# Clean models
clean:
	@echo "Cleaning models..."
	@rm -rf $(GAUSSIAN_PATH)/*
	@rm -rf $(TTS_PATH)/*

# Backup models
backup:
	@echo "Backing up models..."
	@tar -czf models_backup_$(shell date +%Y%m%d).tar.gz $(GAUSSIAN_PATH) $(TTS_PATH)

# Update models
update: backup clean download verify
	@echo "Models updated successfully"
