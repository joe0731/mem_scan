.PHONY: help install install-dev test clean build publish format lint type-check dev-setup

help: ## show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## install package in editable mode
	pip install -e .

install-dev: ## install package with development dependencies
	pip install -e ".[dev]"

install-uv: ## install package using uv
	uv pip install -e .

install-uv-dev: ## install package with dev dependencies using uv
	uv pip install -e ".[dev]"

test: ## run basic test
	mem-scan python -c "import time; print('Testing mem-scan...'); time.sleep(1); print('Test completed!')"

test-with-report: ## run test and save report
	mem-scan --output test_report.json python -c "import time; print('Testing with report...'); time.sleep(2); print('Done!')"
	@echo "Report saved to test_report.json"
	@cat test_report.json

clean: ## clean build artifacts
	rm -rf build/ dist/ *.egg-info/
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -f test_report.json

build: ## build package
	python -m build

build-uv: ## build package using uv
	uv build

format: ## format code with black
	black src/ tests/ --line-length 88

lint: ## run linter
	flake8 src/ tests/

type-check: ## run type checker
	mypy src/

dev-setup: ## setup development environment
	pip install -e ".[dev]"
	@echo "Development environment ready!"

demo: ## run demo with numpy test script
	@echo "Running memory-intensive demo..."
	mem-scan --output demo_report.json python test_script.py
	@echo "\nDemo report:"
	@cat demo_report.json | jq .

# uv specific commands
uv-sync: ## sync dependencies with uv
	uv sync

uv-lock: ## create or update uv.lock
	uv lock

uv-add: ## add a dependency with uv (usage: make uv-add DEP=package_name)
	uv add $(DEP)

# examples
example-basic: ## run basic example
	mem-scan python -c "print('Basic example')"

example-gpu: ## run example with specific GPU
	mem-scan --gpu-id 0 python -c "import time; time.sleep(1); print('GPU example')"

example-quiet: ## run quiet example with output file
	mem-scan --quiet --output quiet_report.json python -c "import time; print('Quiet mode test'); time.sleep(1)"
	@cat quiet_report.json | jq . 