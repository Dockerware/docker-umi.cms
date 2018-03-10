.PHONY: test
.DEFAULT_GOAL := help

help: ## Output usage documentation
	@echo "Usage: make COMMAND [args]\n\nCommands:\n"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " \033[36m%-20s\033[0m %s\n", $$1, $$2}'

duild: ## Build necessary image for building packages
	cd image && IMAGE_NAME=php-fpm-7.1-alpine ../hooks/build

test: lint env-validate ## Run all tests
		
env-validate: duild ## Testing requirements for environment
	cd test && ./run.sh

lint: ## Run static analysis
	shellcheck --exclude=SC2148,SC2046 Makefile
	shellcheck hooks/*
	shellcheck test/*.sh
	shellcheck test/**/*.sh
