SHELL := /bin/bash
.DEFAULT_GOAL := help

# Auto-detect OS
UNAME_S := $(shell uname -s)

# ==============================================================================
# .PHONY: Targets that are not files
# ==============================================================================
.PHONY: help install install-linux install-macos update-submodules

# ------------------------------------------------------------------------------
##@ Main commands
# ------------------------------------------------------------------------------

install: ## Install dotfiles (auto-detect OS)
ifeq ($(UNAME_S),Darwin)
	./install_macos
else ifeq ($(UNAME_S),Linux)
	./install_linux
else
	$(error Unsupported OS: $(UNAME_S))
endif

install-linux: ## Install dotfiles on Linux
	./install_linux

install-macos: ## Install dotfiles on macOS
	./install_macos

# ------------------------------------------------------------------------------
##@ Git commands
# ------------------------------------------------------------------------------

update-submodules: ## Update git submodules
	git submodule sync --quiet --recursive
	git submodule update --init --recursive

# ------------------------------------------------------------------------------
##@ Help command
# ------------------------------------------------------------------------------

help: ## Show Makefile commands help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make <command>\n\033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "- make \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
