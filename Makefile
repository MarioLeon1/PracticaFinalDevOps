.PHONY: help install dev lint test clean

help:
	@echo "Available commands:"
	@echo "  install  - Install all dependencies"
	@echo "  dev      - Start development environment"
	@echo "  lint     - Run all linters"
	@echo "  test     - Run tests"
	@echo "  clean    - Clean up environment"

install:
	@echo "Installing dependencies..."
	npm install
	asdf install

dev:
	@echo "Starting development environment..."
	docker-compose up -d

lint:
	@echo "Running linters..."
	npm run lint
	npm run lint:css

test:
	@echo "Running tests..."
	npm test

clean:
	@echo "Cleaning up..."
	docker-compose down
	rm -rf node_modules
	rm -rf dist