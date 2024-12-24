.PHONY: help install dev lint test clean test-unit test-integration test-coverage test-security test-performance

# Variables
NODE_ENV ?= development

help:
	@echo "Available commands:"
	@echo "  install           - Install all dependencies"
	@echo "  dev               - Start development environment"
	@echo "  lint              - Run all linters"
	@echo "  test              - Run all tests"
	@echo "  test-unit         - Run unit tests"
	@echo "  test-integration  - Run integration tests"
	@echo "  test-security     - Run security tests"
	@echo "  test-performance  - Run performance tests"
	@echo "  test-coverage     - Run tests with coverage"
	@echo "  clean             - Clean up environment"

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

test: node_modules
	@echo "Running all tests..."
	npm run test

test-unit: node_modules
	@echo "Running unit tests..."
	npm run test:unit

test-integration: node_modules
	@echo "Running integration tests..."
	npm run test:integration

test-coverage: node_modules
	@echo "Running tests with coverage..."
	npm run test:coverage

clean:
	@echo "Cleaning up..."
	docker-compose down
	rm -rf node_modules
	rm -rf dist

.PHONY: release-patch release-minor release-major

release-patch:
	@echo "Creating patch release..."
	npm run release:patch

release-minor:
	@echo "Creating minor release..."
	npm run release:minor

release-major:
	@echo "Creating major release..."
	npm run release:major

.PHONY: tf-init tf-plan tf-apply tf-destroy

tf-init:
	@echo "Initializing Terraform..."
	cd terraform && terraform init

tf-plan:
	@echo "Planning Terraform changes..."
	cd terraform && terraform plan

tf-apply:
	@echo "Applying Terraform changes..."
	cd terraform && terraform apply -auto-approve

tf-destroy:
	@echo "Destroying Terraform infrastructure..."
	cd terraform && terraform destroy -auto-approve