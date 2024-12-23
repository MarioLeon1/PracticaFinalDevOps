.PHONY: help install dev lint test clean

# Variables
NODE_ENV ?= development

help:
	@echo "Available commands:"
	@echo "  install  - Install all dependencies"
	@echo "  dev      - Start development environment"
	@echo "  lint     - Run all linters"
	@echo "  test     - Run tests"
	@echo "  clean    - Clean up environment"

install:
	@echo "Installing dependencies..."
	@if [ ! -f package.json ]; then \
		npm init -y; \
	fi
	npm install
	@if command -v poetry >/dev/null 2>&1; then \
		poetry install; \
	else \
		pip install -r requirements.txt; \
	fi

dev:
	@echo "Starting development environment..."
	docker-compose up -d

lint: node_modules
	@echo "Running linters..."
	@if [ -f .eslintrc.js ]; then \
		npx eslint . --ext .js; \
	fi
	@if [ -f .stylelintrc ]; then \
		npx stylelint "**/*.css"; \
	fi

node_modules:
	@if [ ! -d node_modules ]; then \
		npm install; \
	fi

test:
	@echo "Running tests..."
	@echo "No tests configured yet"

clean:
	@echo "Cleaning up..."
	docker-compose down
	rm -rf node_modules
	rm -rf dist