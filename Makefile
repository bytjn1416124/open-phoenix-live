#################################################################################
#                      OpenPhoenix Live Makefile                               #
#################################################################################

# Ensure all commands in a target run in the same shell
.ONESHELL:

# Use bash shell with strict error checking
SHELL := /bin/bash
.SHELLFLAGS := -euo pipefail -c

# Mark targets that don't create files
.PHONY: all setup dev test lint clean deploy help download-models check-env client server docker

# Environment variables
PYTHON := python3
PIP := pip3
NPM := npm

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

setup: check-env
	@echo "${COLOR_BLUE}Setting up OpenPhoenix Live...${COLOR_RESET}"
	@chmod +x scripts/*.sh
	@./scripts/setup.sh
	@echo "${COLOR_GREEN}Setup complete!${COLOR_RESET}"

# Download pre-trained models
download-models: check-env
	@echo "${COLOR_BLUE}Downloading pre-trained models...${COLOR_RESET}"
	@./scripts/download_models.sh

#################################################################################
#                           Development Commands                                 #
#################################################################################

# Start development environment
dev: check-env
	@echo "${COLOR_BLUE}Starting development environment...${COLOR_RESET}"
	@./scripts/dev.sh

# Start frontend development
client: check-env
	@echo "${COLOR_BLUE}Starting frontend development...${COLOR_RESET}"
	cd client && $(NPM) start

# Start backend development
server: check-env
	@echo "${COLOR_BLUE}Starting backend services...${COLOR_RESET}"
	$(PYTHON) -m server.main_server

#################################################################################
#                              Docker Commands                                   #
#################################################################################

# Build Docker images
docker-build:
	@echo "${COLOR_BLUE}Building Docker images...${COLOR_RESET}"
	docker-compose build

# Start Docker services
docker-up:
	@echo "${COLOR_BLUE}Starting Docker services...${COLOR_RESET}"
	docker-compose up -d

# Stop Docker services
docker-down:
	@echo "${COLOR_BLUE}Stopping Docker services...${COLOR_RESET}"
	docker-compose down

#################################################################################
#                              Test Commands                                     #
#################################################################################

# Run all tests
test: test-unit test-integration lint

# Run unit tests
test-unit: check-env
	@echo "${COLOR_BLUE}Running unit tests...${COLOR_RESET}"
	$(PYTHON) -m pytest tests/unit -v --cov=server --cov-report=term-missing

# Run integration tests
test-integration: check-env
	@echo "${COLOR_BLUE}Running integration tests...${COLOR_RESET}"
	$(PYTHON) -m pytest tests/integration -v

# Run Python linters
lint: check-env
	@echo "${COLOR_BLUE}Running linters...${COLOR_RESET}"
	flake8 server/
	black --check server/
	isort --check-only server/
	cd client && $(NPM) run lint

#################################################################################
#                           Deployment Commands                                  #
#################################################################################

# Deploy the application
deploy: check-env
	@echo "${COLOR_BLUE}Deploying application...${COLOR_RESET}"
	@./scripts/deploy.sh

# Build for production
build: check-env
	@echo "${COLOR_BLUE}Building for production...${COLOR_RESET}"
	$(PYTHON) setup.py build
	cd client && $(NPM) run build

#################################################################################
#                           Cleanup Commands                                     #
#################################################################################

# Clean up generated files
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
	# Clean Docker
	docker-compose down --rmi all -v --remove-orphans || true

#################################################################################
#                              Helper Commands                                   #
#################################################################################

# Check environment
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
	@echo "  make dev            - Start complete development environment"
	@echo "  make client         - Start frontend development only"
	@echo "  make server         - Start backend services only"
	@echo ""
	@echo "Docker Commands:"
	@echo "  make docker-build   - Build all Docker images"
	@echo "  make docker-up      - Start Docker services"
	@echo "  make docker-down    - Stop Docker services"
	@echo ""
	@echo "Test Commands:"
	@echo "  make test           - Run all tests and linters"
	@echo "  make test-unit      - Run unit tests"
	@echo "  make test-integration - Run integration tests"
	@echo "  make lint           - Run linters"
	@echo ""
	@echo "Deployment Commands:"
	@echo "  make deploy         - Deploy the application"
	@echo "  make build          - Build for production"
	@echo ""
	@echo "Cleanup Commands:"
	@echo "  make clean          - Clean up generated files"
