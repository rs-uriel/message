BUILD := $(CURDIR)/build

build.dev.worker: ## Build Image with tag
	@echo "Build Image with tag..."
	docker build -f $(BUILD)/worker/Dockerfile.dev .