.PHONY: help build install test clean generate download-spec lint format

help:
	@echo "Kubernetes Client for Crystal"
	@echo ""
	@echo "Available targets:"
	@echo "  make download-spec - Download Kubernetes OpenAPI spec"
	@echo "  make generate      - Generate API bindings from swagger.json"
	@echo "  make build         - Build the library"
	@echo "  make test          - Run tests"
	@echo "  make lint          - Run linter (ameba)"
	@echo "  make format        - Format code"
	@echo "  make clean         - Clean generated files"

download-spec:
	@echo "Downloading Kubernetes OpenAPI specification..."
	curl -L https://raw.githubusercontent.com/kubernetes/kubernetes/master/api/openapi-spec/swagger.json -o swagger.json
	@echo "Downloaded swagger.json"

generate:
	@if [ ! -f swagger.json ]; then \
		echo "swagger.json not found. Run 'make download-spec' first."; \
		exit 1; \
	fi
	@echo "Generating API bindings from swagger.json..."
	@rm -rf src/generated
	@mkdir -p src/generated/models src/generated/api
	crystal run src/generator/main.cr -- swagger.json src/generated
	@echo "Code generation complete"
	@echo "Formatting code..."
	crystal tool format
	@echo "Format complete"

build:
	@echo "Building kubernetes-client..."
	shards build
	@echo "Build complete"

test:
	@echo "Running tests..."
	crystal spec
	@echo "Tests complete"

lint:
	@echo "Running linter..."
	bin/ameba
	@echo "Lint complete"

format:
	@echo "Formatting code..."
	crystal tool format
	@echo "Format complete"

clean:
	@echo "Cleaning generated files..."
	rm -rf src/generated/ lib/ bin/
	@echo "Clean complete"

.DEFAULT_GOAL := help
