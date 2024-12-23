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

test: test-unit test-integration test-security test-performance

test-unit:
	@echo "Running unit tests..."
	npx jest tests/unit/auth.test.js

test-integration:
	@echo "Running integration tests..."
	npx jest tests/integration/api.test.js

test-security:
	@echo "Running security tests..."
	ZAP_API_KEY=$$ZAP_API_KEY npx jest tests/security/security.test.js

test-performance:
	@echo "Running performance tests..."
	npx k6 run tests/performance/load.test.js

test-coverage:
	@echo "Running tests with coverage..."
	npx jest --coverage

clean:
	@echo "Cleaning up..."
	docker-compose down
	rm -rf node_modules
	rm -rf dist
