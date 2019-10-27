SHELL = /usr/bin/env bash

.PHONY: help
help: ## Print this info and exit
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk '\
			BEGIN {printf "%-30s\n\n", "Targets"}; \
			BEGIN {FS = ":.*?## "}; \
			{printf "\033[36m%-30s\033[0m%s\n", $$1, $$2}; \
		'

.PHONY: build
build: ## Build docker image
	./scripts/build.sh

.PHONY: up
up: ## Run application and tail logs
	./scripts/up.sh
