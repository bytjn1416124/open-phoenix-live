#################################################################################
#                      OpenPhoenix Live Makefile                               #
#################################################################################

# Ensure all commands in a target run in the same shell
.ONESHELL:

# Use bash shell with strict error checking
SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

# Mark targets that don't create files
.PHONY: all setup dev test lint clean deploy help download-models check-env client server docker models

# Environment variables
PYTHON := python3
PIP := pip3
NPM := npm

# Model paths
MODELS_DIR := models
GAUSSIAN_MODEL_DIR := $(MODELS_DIR)/3d_gs
TTS_MODEL_DIR := $(MODELS_DIR)/tts

# Colors for pretty printing
COLOR_RESET := \033[0m
COLOR_BLUE := \033[34m
COLOR_GREEN := \033[32m
COLOR_YELLOW := \033[33m
COLOR_RED := \033[31m

# Default target when running just 'make'
all: help

#################################################################################
#                              Setup Commands                                    #
#################################################################################

setup: check-env create-model-dirs
	@echo "${COLOR_BLUE}Setting up OpenPhoenix Live...${COLOR_RESET}"
	@chmod +x scripts/*.sh
	@./scripts/setup.sh
	@echo "${COLOR_GREEN}Setup complete!${COLOR_RESET}"

# Create model directories
create-model-dirs:
	@echo "${COLOR_BLUE}Creating model directories...${COLOR_RESET}"
	mkdir -p $(GAUSSIAN_MODEL_DIR)
	mkdir -p $(TTS_MODEL_DIR)

# Download pre-trained models
download-models: check-env create-model-dirs
	@echo "${COLOR_BLUE}Downloading pre-trained models...${COLOR_RESET}"
	@./scripts/download_models.sh

# Download 3D Gaussian models only
download-gaussian-models: check-env
	@echo "${COLOR_BLUE}Downloading 3D Gaussian models...${COLOR_RESET}"
	@./scripts/download_models.sh gaussian

# Download TTS models only
download-tts-models: check-env
	@echo "${COLOR_BLUE}Downloading TTS models...${COLOR_RESET}"
	@./scripts/download_models.sh tts

# Verify model downloads
verify-models:
	@echo "${COLOR_BLUE}Verifying model files...${COLOR_RESET}"
	@./scripts/verify_models.sh

[Rest of the Makefile remains the same...]
