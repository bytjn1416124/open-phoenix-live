#################################################################################
#                      OpenPhoenix Live Makefile                               #
#################################################################################

[Previous Makefile content...]

# Model directory structure
MODELS_DIR := models
GAUSSIAN_DIR := $(MODELS_DIR)/3d_gs
TTS_DIR := $(MODELS_DIR)/tts
STT_DIR := $(MODELS_DIR)/stt
MODEL_BACKUP_DIR := $(MODELS_DIR)/backups

# Model file paths
GAUSSIAN_MODEL := $(GAUSSIAN_DIR)/pretrained_model.pth
GAUSSIAN_CONFIG := $(GAUSSIAN_DIR)/config.yaml
TTS_MODEL := $(TTS_DIR)/coqui_model.pth
TTS_CONFIG := $(TTS_DIR)/config.json
STT_MODEL := $(STT_DIR)/vosk-model-small-en-us
STT_CONFIG := $(STT_DIR)/config.json

# Create model directories
create-model-dirs:
	@echo "${COLOR_BLUE}Creating model directories...${COLOR_RESET}"
	mkdir -p $(GAUSSIAN_DIR)
	mkdir -p $(TTS_DIR)
	mkdir -p $(STT_DIR)
	mkdir -p $(MODEL_BACKUP_DIR)

# Download models
download-models: download-gaussian-models download-tts-models download-stt-models

download-stt-models: create-model-dirs
	@echo "${COLOR_BLUE}Downloading STT models...${COLOR_RESET}"
	@./scripts/download_models.sh stt

[Rest of the Makefile content...]

# Add to help target
help:
	@echo "Model Management:"
	@echo "  make download-stt-models    - Download STT models"
	[Rest of help content...]
