# Add to existing Makefile...

#################################################################################
#                              Model Management                                  #
#################################################################################

# Model directory structure
MODELS_DIR := models
GAUSSIAN_DIR := $(MODELS_DIR)/3d_gs
TTS_DIR := $(MODELS_DIR)/tts
MODEL_BACKUP_DIR := $(MODELS_DIR)/backups

# Model file paths
GAUSSIAN_MODEL := $(GAUSSIAN_DIR)/pretrained_model.pth
GAUSSIAN_CONFIG := $(GAUSSIAN_DIR)/config.yaml
TTS_MODEL := $(TTS_DIR)/coqui_model.pth
TTS_CONFIG := $(TTS_DIR)/config.json

# Create model directories
create-model-dirs:
	@echo "${COLOR_BLUE}Creating model directories...${COLOR_RESET}"
	mkdir -p $(GAUSSIAN_DIR)
	mkdir -p $(TTS_DIR)
	mkdir -p $(MODEL_BACKUP_DIR)

# Download models
download-models: download-gaussian-models download-tts-models

download-gaussian-models: create-model-dirs
	@echo "${COLOR_BLUE}Downloading 3D Gaussian models...${COLOR_RESET}"
	@./scripts/download_models.sh gaussian

download-tts-models: create-model-dirs
	@echo "${COLOR_BLUE}Downloading TTS models...${COLOR_RESET}"
	@./scripts/download_models.sh tts

# Verify models
verify-models: verify-gaussian-models verify-tts-models

verify-gaussian-models:
	@echo "${COLOR_BLUE}Verifying 3D Gaussian models...${COLOR_RESET}"
	@test -f $(GAUSSIAN_MODEL) || (echo "${COLOR_RED}Missing: $(GAUSSIAN_MODEL)${COLOR_RESET}" && exit 1)
	@test -f $(GAUSSIAN_CONFIG) || (echo "${COLOR_RED}Missing: $(GAUSSIAN_CONFIG)${COLOR_RESET}" && exit 1)
	@echo "${COLOR_GREEN}3D Gaussian models verified!${COLOR_RESET}"

verify-tts-models:
	@echo "${COLOR_BLUE}Verifying TTS models...${COLOR_RESET}"
	@test -f $(TTS_MODEL) || (echo "${COLOR_RED}Missing: $(TTS_MODEL)${COLOR_RESET}" && exit 1)
	@test -f $(TTS_CONFIG) || (echo "${COLOR_RED}Missing: $(TTS_CONFIG)${COLOR_RESET}" && exit 1)
	@echo "${COLOR_GREEN}TTS models verified!${COLOR_RESET}"

# Backup models
backup-models: create-model-dirs
	@echo "${COLOR_BLUE}Backing up models...${COLOR_RESET}"
	@timestamp=$$(date +%Y%m%d_%H%M%S); \
	backup_dir=$(MODEL_BACKUP_DIR)/backup_$$timestamp; \
	mkdir -p $$backup_dir; \
	cp -r $(GAUSSIAN_DIR)/* $$backup_dir/gaussian/ 2>/dev/null || true; \
	cp -r $(TTS_DIR)/* $$backup_dir/tts/ 2>/dev/null || true; \
	echo "${COLOR_GREEN}Models backed up to: $$backup_dir${COLOR_RESET}"

# Update models
update-models: backup-models download-models verify-models
	@echo "${COLOR_GREEN}Models updated successfully!${COLOR_RESET}"

# Clean models
clean-models:
	@echo "${COLOR_BLUE}Cleaning model directories...${COLOR_RESET}"
	rm -rf $(GAUSSIAN_DIR)/*
	rm -rf $(TTS_DIR)/*
	@echo "${COLOR_GREEN}Model directories cleaned!${COLOR_RESET}"

# Model integrity check
check-model-integrity:
	@echo "${COLOR_BLUE}Checking model integrity...${COLOR_RESET}"
	@./scripts/verify_models.sh

# Add to the help target
help: # Add under the existing help section
	@echo "Model Management:"
	@echo "  make download-models        - Download all models"
	@echo "  make download-gaussian-models - Download 3D Gaussian models"
	@echo "  make download-tts-models    - Download TTS models"
	@echo "  make verify-models         - Verify all models"
	@echo "  make backup-models         - Backup current models"
	@echo "  make update-models         - Update to latest models"
	@echo "  make clean-models          - Remove all models"
	@echo "  make check-model-integrity - Check model file integrity"
