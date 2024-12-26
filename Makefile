################################################################################
#                         OpenPhoenix Live Makefile                           #
################################################################################

# This Makefile provides commands for managing the OpenPhoenix Live project.
# It includes targets for setup, development, testing, deployment, and maintenance.

# Ensure all commands in a target run in the same shell
.ONESHELL:

# Use bash shell with strict error checking
SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

# Mark targets that don't create files
.PHONY: all setup dev test lint clean deploy help download-models check-env

# Environment variables
PYTHON := python3
PIP := pip3
NPM := npm

# Colors for pretty printing
COLOR_RESET := \033[0m
COLOR_BLUE := \033[34m
COLOR_GREEN := \033[32m
COLOR_YELLOW := \033[33m

# Default target when running just 'make'
all: help

################################################################################
#                              Setup Commands                                   #
################################################################################

# Complete setup of the development environment
setup: check-env
	@echo "${COLOR_BLUE}Setting up OpenPhoenix Live development environment...${COLOR_RESET}"
	@chmod +x scripts/*.sh
	@./scripts/setup.sh
	@echo "${COLOR_GREEN}Setup complete! Run 'make download-models' to download required models.${COLOR_RESET}"

# Download pre-trained models
download-models: check-env
	@echo "${COLOR_BLUE}Downloading pre-trained models...${COLOR_RESET}"
	@./scripts/download_models.sh

################################################################################
#                           Development Commands                                #
################################################################################

# Start development servers
dev: check-env
	@echo "${COLOR_BLUE}Starting development servers...${COLOR_RESET}"
	@./scripts/dev.sh

# Run all tests
test: test-unit test-integration

# Run unit tests only
test-unit: check-env
	@echo "${COLOR_BLUE}Running unit tests...${COLOR_RESET}"
	$(PYTHON) -m pytest tests/unit -v --cov=server --cov-report=term-missing

# Run integration tests only
test-integration: check-env
	@echo "${COLOR_BLUE}Running integration tests...${COLOR_RESET}"
	$(PYTHON) -m pytest tests/integration -v

# Run linters
lint: lint-python lint-js

# Run Python linters
lint-python: check-env
	@echo "${COLOR_BLUE}Running Python linters...${COLOR_RESET}"
	flake8 server/
	black --check server/
	isort --check-only server/

# Run JavaScript linters
lint-js: check-env
	@echo "${COLOR_BLUE}Running JavaScript linters...${COLOR_RESET}"
	cd client && $(NPM) run lint

################################################################################
#                           Deployment Commands                                 #
################################################################################

# Deploy the application
deploy: check-env build
	@echo "${COLOR_BLUE}Deploying application...${COLOR_RESET}"
	@./scripts/deploy.sh

# Build the application
build: check-env
	@echo "${COLOR_BLUE}Building application...${COLOR_RESET}"
	# Build Python package
	$(PYTHON) setup.py build
	# Build React client
	cd client && $(NPM) run build

################################################################################
#                           Maintenance Commands                                #
################################################################################

# Clean up generated files and caches
clean:
	@echo "${COLOR_BLUE}Cleaning up...${COLOR_RESET}"
	# Clean Python cache
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name '*.pyc' -delete
	# Clean test cache
	find . -type d -name .pytest_cache -exec rm -rf {} +
	# Clean coverage reports
	rm -f .coverage
	rm -f coverage.xml
	# Clean Node modules
	[ -d client/node_modules ] && rm -rf client/node_modules || true
	# Clean builds
	[ -d client/build ] && rm -rf client/build || true
	[ -d dist ] && rm -rf dist || true
	[ -d build ] && rm -rf build || true
	# Clean virtual environment
	[ -d venv ] && rm -rf venv || true
	@echo "${COLOR_GREEN}Cleanup complete!${COLOR_RESET}"

# Deep clean - remove all generated files and dependencies
clean-all: clean
	@echo "${COLOR_BLUE}Performing deep clean...${COLOR_RESET}"
	# Remove all downloaded models
	rm -rf models/*
	# Remove logs
	rm -rf logs/*
	# Keep .gitkeep files
	touch models/.gitkeep logs/.gitkeep

# Format code
format: check-env
	@echo "${COLOR_BLUE}Formatting code...${COLOR_RESET}"
	# Format Python code
	black server/
	isort server/
	# Format JavaScript code
	cd client && $(NPM) run format

################################################################################
#                              Helper Commands                                  #
################################################################################

# Check required environment variables
check-env:
	@if [ ! -f .env ]; then
		echo "${COLOR_YELLOW}Warning: .env file not found. Copying from .env.example...${COLOR_RESET}"
		cp .env.example .env
	fi

# Display help information
help:
	@echo "${COLOR_BLUE}OpenPhoenix Live Makefile Commands:${COLOR_RESET}"
	@echo ""
	@echo "Setup Commands:"
	@echo "  make setup          - Set up development environment"
	@echo "  make download-models - Download pre-trained models"
	@echo ""
	@echo "Development Commands:"
	@echo "  make dev            - Start development servers"
	@echo "  make test           - Run all tests"
	@echo "  make test-unit      - Run unit tests only"
	@echo "  make test-integration - Run integration tests only"
	@echo "  make lint           - Run all linters"
	@echo "  make format         - Format code"
	@echo ""
	@echo "Deployment Commands:"
	@echo "  make deploy         - Deploy the application"
	@echo "  make build          - Build the application"
	@echo ""
	@echo "Maintenance Commands:"
	@echo "  make clean          - Clean up generated files"
	@echo "  make clean-all      - Remove all generated files and dependencies"
	@echo ""
	@echo "Helper Commands:"
	@echo "  make help           - Display this help message"
	@echo ""
	@echo "Example usage:"
	@echo "  make setup download-models  # Complete initial setup"
	@echo "  make dev                    # Start development environment"
	@echo "  make test lint              # Run tests and linters"
