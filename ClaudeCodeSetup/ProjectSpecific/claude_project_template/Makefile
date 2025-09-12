# Makefile for Claude Code Project Template
.PHONY: help dev build clean test lint format git-status git-diff docker-up docker-down

# Default target
help:
	@echo "Available commands:"
	@echo "  make dev          - Start development environment"
	@echo "  make build        - Build the project"
	@echo "  make clean        - Clean build artifacts"
	@echo "  make test         - Run all tests"
	@echo "  make lint         - Run all linters"
	@echo "  make format       - Format all code"
	@echo "  make git-status   - Show git status"
	@echo "  make git-diff     - Show uncommitted changes"
	@echo "  make git-log      - Show recent commits"
	@echo "  make docker-up    - Start Docker services"
	@echo "  make docker-down  - Stop Docker services"

# Development
dev: lint test
	@echo "Development environment ready"

build:
	@echo "Building project..."
	-npm run build 2>/dev/null || true
	-python setup.py build 2>/dev/null || true

clean:
	@echo "Cleaning build artifacts..."
	rm -rf build/ dist/ *.egg-info/ __pycache__/ .pytest_cache/ .coverage
	rm -rf node_modules/.cache/
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true

# Testing
test: test-unit test-integration

test-unit:
	@echo "Running unit tests..."
	-npm test 2>/dev/null || true
	-python -m pytest tests/unit -v 2>/dev/null || true

test-integration:
	@echo "Running integration tests..."
	-npm run test:integration 2>/dev/null || true
	-python -m pytest tests/integration -v 2>/dev/null || true

test-coverage:
	@echo "Running tests with coverage..."
	-npm run test:coverage 2>/dev/null || true
	-python -m pytest --cov=src --cov-report=html --cov-report=term 2>/dev/null || true

test-watch:
	@echo "Running tests in watch mode..."
	-npm run test:watch 2>/dev/null || true

# Linting and Formatting
lint: lint-js lint-python

lint-js:
	@echo "Linting JavaScript/TypeScript..."
	-npx eslint . --ext .js,.jsx,.ts,.tsx 2>/dev/null || true

lint-python:
	@echo "Linting Python..."
	-ruff check . 2>/dev/null || true
	-mypy . 2>/dev/null || true

lint-fix:
	@echo "Auto-fixing linting issues..."
	-npx eslint . --ext .js,.jsx,.ts,.tsx --fix 2>/dev/null || true
	-ruff check . --fix 2>/dev/null || true

format: format-js format-python

format-js:
	@echo "Formatting JavaScript/TypeScript..."
	npx prettier --write "**/*.{js,jsx,ts,tsx,json,css,md}"

format-python:
	@echo "Formatting Python..."
	black .

format-check:
	@echo "Checking formatting..."
	npx prettier --check "**/*.{js,jsx,ts,tsx,json,css,md}"
	black --check .

# Git Commands
git-status:
	git status

git-diff:
	git diff HEAD

git-diff-staged:
	git diff --staged

# Show diff for last N commits (usage: make git-diff-range COMMITS=5)
git-diff-range:
	git diff HEAD~$(or $(COMMITS),5)..HEAD

# Show diff for specific commit (usage: make git-diff-commit COMMIT=abc123)
git-diff-commit:
	git show $(or $(COMMIT),HEAD)

# Show diff between two commits (usage: make git-diff-between FROM=main TO=feature)
git-diff-between:
	git diff $(FROM)..$(or $(TO),HEAD)

git-log:
	git log --oneline -10

git-log-detailed:
	git log --stat -$(or $(COUNT),10)

git-log-graph:
	git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -20

# List files changed in last N commits (usage: make git-files-changed COMMITS=5)
git-files-changed:
	git diff --name-only HEAD~$(or $(COMMITS),1)..HEAD

# Show blame for file (usage: make git-blame FILE=src/main.py)
git-blame:
	git blame $(FILE)

# Project Information
info:
	@echo "Project Structure:"
	@find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.ts" \) | head -20
	@echo ""
	@echo "Git Status:"
	@git status --short
	@echo ""
	@echo "Recent Commits:"
	@git log --oneline -5

# Dependencies
deps-check:
	@echo "Checking dependencies..."
	-npm outdated 2>/dev/null || true
	-pip list --outdated 2>/dev/null || true

deps-install:
	@echo "Installing dependencies..."
	-npm install 2>/dev/null || true
	-pip install -r requirements.txt 2>/dev/null || true

deps-update:
	@echo "Updating dependencies..."
	-npm update 2>/dev/null || true
	-pip install --upgrade -r requirements.txt 2>/dev/null || true

# Security
security-check:
	@echo "Running security checks..."
	-npm audit 2>/dev/null || true
	-pip-audit 2>/dev/null || true

security-fix:
	@echo "Fixing security issues..."
	-npm audit fix 2>/dev/null || true

# Docker Commands (for MCP servers)
docker-up:
	cd ../claude_code_infra && docker-compose up -d

docker-down:
	cd ../claude_code_infra && docker-compose down

docker-logs:
	cd ../claude_code_infra && docker-compose logs -f

docker-build:
	cd ../claude_code_infra && docker-compose build

docker-status:
	docker ps --filter "name=claude-"