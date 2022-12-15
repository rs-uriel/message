PROJECT_NAME := message
MODULE_NAME := github.com/rs-uriel/message
SOURCE := $(shell git rev-parse --show-toplevel)

# include $(SOURCE)/scripts/make/build.mk
include $(SOURCE)/scripts/make/local.mk

# ENV?=dev
# PYTHON_CONTAINER=worker
# CONTAINER=worker
# COMMAND=/bin/bash
# ENV_FILE=./.env.$(ENV)

# DOCKER_COMPOSE=docker-compose -f docker-compose.yml -f docker-compose.$(ENV).yml
# DOCKER_COMPOSE_RUN=$(DOCKER_COMPOSE) run -e ENV=$(ENV) --rm $(PYTHON_CONTAINER)

# .PHONY: all test_env test test-watcher coverage lint codestyle exec join console build-image-local run stop help

# all: build-image-local run ## Build the Image and then run it

# test_env:
# ifneq ($(ENV),ci)
# 	$(eval ENV := test)
# endif

# test: test_env ## Run Test on the project
# 	$(DOCKER_COMPOSE_RUN) pytest -vv ${file} -x

# test-watcher: test_env ## Run Test on the project + Add a watcher to re-run tests on file change
# 	$(DOCKER_COMPOSE_RUN) ptw

# coverage: test_env ## Run the test coverage
# 	$(DOCKER_COMPOSE_RUN) pytest --cov=./ --cov-fail-under=90 --cov-config=.coveragerc

# lint: test_env ## Run the linter
# 	$(DOCKER_COMPOSE_RUN) pylint --fail-under=9 ./src/**/*.py ./lib/**/*.py ./test/**/*.py

# codestyle: test_env ## Run the Code style checker
# 	$(DOCKER_COMPOSE_RUN) pycodestyle --count src/ lib/ test/

# autofixer: test_env ## AutoFix codestyle and lint
# 	$(DOCKER_COMPOSE_RUN) autopep8 --in-place --recursive --verbose ./src/

# exec: ## Exec bash terminal inside container
# 	$(DOCKER_COMPOSE) exec $(CONTAINER) $(COMMAND)

# join: ## Exec python interactive console inside worker container
# 	$(DOCKER_COMPOSE) exec worker /bin/bash

# console: ## Exec python interactive console inside worker container
# 	$(DOCKER_COMPOSE) run worker python

# build-image-local: ## Build docker-compose images
# 	$(DOCKER_COMPOSE) build

# run: ## Run docker compose
# 	$(DOCKER_COMPOSE) up -d

# stop: ## Stop running docker containers
# 	$(DOCKER_COMPOSE) stop

# ## --- DEPLOYMENTS ---
# login: ## Login to AWS
# 	@echo "Logging in to ECR (AWS Docker repository)"
# 	aws ecr get-login-password | docker login --username AWS --password-stdin $(DOCKER_REGISTRY)/arse-cadence-worker:$(ENV)

# build-image: ## Build the worker docker image
# 	docker build -t arse-cadence-worker:latest -f Dockerfile .

# tag: build-image ## Tag the docker image
# 	docker tag arse-cadence-worker:latest $(ECR_REPO):$(ENV)

# push: login tag ## Push Docker Image
# 	docker push $(ECR_REPO):$(ENV)

help: ## Display Help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
