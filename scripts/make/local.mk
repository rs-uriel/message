# Docker compose
DEPLOYMENT := $(CURDIR)/deployments
DOCKER_COMPOSE := $(DEPLOYMENT)/docker-compose
DOCKER_COMPOSE_CMD = docker-compose -p $(PROJECT_NAME)
# DOCKER_COMPOSE_CLEAN_FLAGS=--volumes --rmi local --remove-orphans

# CONTAINER=pdm
# RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

.PHONY: local.build

local.build: ## Build Local environment
	@echo "Build local environment..."
	$(DOCKER_COMPOSE_CMD) -f $(DOCKER_COMPOSE)/docker-compose.local.yml build

local.run: ## Run Local environment
	@echo "Run local environment..."
	$(DOCKER_COMPOSE_CMD) -f $(DOCKER_COMPOSE)/docker-compose.local.yml up