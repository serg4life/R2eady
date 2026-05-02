# project-configurator: GitHub Copilot Instructions

## Project Overview

**project-configurator** is a comprehensive multi-language repository scaffolding and AI automation tool. It provides:

1. **Language Templates**: Python, C++, Bash, Docker with pre-configured CI/CD
2. **AI Toolsets**: GitHub Copilot agents, skills, prompts, instructions, and automation hooks
3. **Automation Hooks**: Git-integrated hooks for automatic test generation and documentation updates
4. **Development Patterns**: Industry-standard templates and best practices across all supported languages

The project is designed to accelerate development by providing production-ready boilerplate, intelligent automation, and AI-powered development assistance.

## Architecture & Key Components

### Core Script
- **`initialize_repo.sh`**: Main entry point for repository initialization
  - `init()`: Creates standard structure (`src/`, `tests/`, `docs/`, `lib/`)
  - `bare_init()`: Minimal setup (README.md, .gitignore, Git repo)
  - `init_aitools()`: **NEW** - Installs GitHub Copilot AI toolset
  - Supports `--bare` flag and multiple language configurations

### Language Templates
Located in dedicated directories (`python/`, `C++/`, `bash/`, `docker/`):
- Pre-configured CI/CD workflows
- Language-specific linting and testing setup
- Build configuration files (pyproject.toml, CMakeLists.txt, etc.)
- Initialization scripts for each language

**Example (Python)**:
- `pyproject.toml` with Ruff configuration (rules: E, W, F, N)
- `requirements.txt` with pytest and common dependencies
- `workflows/python-lint.yaml` - Auto-fix linting on CI/CD

### AI Toolset Components
Located in `ai-toolset/GENERAL/`:

#### Agents
Specialized GitHub Copilot personas for different development roles:
- `debug.agent.md` - Debugging and issue diagnosis
- `principal-software-engineer.agent.md` - Architecture guidance
- `se-security-reviewer.agent.md` - Security code review
- `se-gitops-ci-specialist.agent.md` - DevOps and CI/CD
- `se-performance-reviewer.agent.md` - Performance optimization
- `embedded-planner.agent.md` - Embedded systems design
- And more specialized agents

#### Skills
Reusable AI capabilities for specific development tasks:
- `create-implementation-plan` - Feature planning
- `create-firmware-architecture-plan` - Embedded systems
- `autoresearch` - Autonomous optimization loops
- `git-commit` - Conventional commit assistance
- `refactor` - Code refactoring
- Plus 13+ additional reusable skills

#### Prompts
Pre-engineered prompts for common workflows:
- `create-agent.prompt.md` - Creating new agents
- `create-skill.prompt.md` - Creating new skills
- `embedded-planning.prompt.md` - Firmware planning
- `embedded-security.prompt.md` - Security analysis

#### Instructions
Custom Copilot behavior guidelines:
- `agent-safety.instructions.md` - Safe AI agent systems
- `performance-optimization.instructions.md` - Optimization techniques
- `self-explanatory-code-commenting.instructions.md` - Code comments
- And more domain-specific instructions

#### Hooks (NEW!)
**Git integration for automation**:

1. **generate-test** (NEW)
   - Automatically generates unit tests from git diff
   - Supports Python (pytest), JavaScript (Jest), C++ (Google Test)
   - Smart language detection and test framework mapping
   - Accessible via: `.github/hooks/generate-test/generate-tests.sh`
   - Configuration: `.github/hooks/generate-test/hooks.json`
   - Trigger: `prePush` hook (before pushing to remote)

2. **update-doc** (NEW)
   - Automatically generates/updates documentation from git changes
   - Updates README.md, CHANGELOG.md, API docs
   - Smart change detection for new functions/classes
   - Accessible via: `.github/hooks/update-doc/update-documentation.sh`
   - Configuration: `.github/hooks/update-doc/hooks.json`
   - Trigger: `prePush` hook

3. **Existing Hooks**
   - `session-logger` - Logs Copilot session activity
   - `session-auto-commit` - Automatic commit generation
   - `governance-audit` - Compliance and audit tracking

## Conventions & Patterns

### Naming Conventions
- **Files**: Use kebab-case (lowercase with hyphens)
  - Examples: `bug-report.md`, `pull-request-template.md`, `generate-tests.sh`
- **Git Commits**: Use conventional commits (feat, fix, docs, etc.)
- **Branches**: `main` and `develop` are default branches

### Initialization Scripts
- Use Bash with POSIX compliance for portability
- Check file/directory existence before creation (use `-d` for dirs, `-f` for files)
- Provide user feedback (echo) for each step
- Handle already-existing files/directories gracefully

### Python Projects
- **Linter**: Ruff with rules `E, W, F, N` (PEP8, logic, naming)
- **Test Framework**: pytest
- **Configuration**: Centralized in `pyproject.toml` under `[tool.ruff]`
- **Exclusions**: venv, .git, __pycache__

### AI Toolset Installation
- Copy all resources to `.github/` directory
- Make hook scripts executable (`chmod +x *.sh`)
- Create `logs/copilot/` directory for hook execution logs
- Configure hooks in respective `hooks.json` files

## Developer Workflows

### Initialize New Repository
```bash
# Standard initialization (creates src/, tests/, docs/, lib/)
./initialize_repo.sh

# Minimal initialization (only README, .gitignore, .git)
./initialize_repo.sh --bare

# Language-specific
./initialize_repo.sh python
./initialize_repo.sh cpp

# Install AI Toolset (NEW!)
./initialize_repo.sh ai-toolset

# Bare initialization only (skip directory structure)
./initialize_repo.sh --bare
```

### Python Project Setup
1. Run language template's init script if present
2. Install dependencies: `pip install -r requirements.txt`
3. Configure Ruff in `pyproject.toml` as needed
4. Commit to trigger CI/CD lint workflow

### Linting & Auto-Fix
- Python projects automatically fixed on CI/CD push via Ruff
- Manual fix: `ruff check . --fix`

## Automation Hooks Guide

### generate-test Hook

**Purpose**: Automatically generates unit tests based on git diff changes

**Location**: `.github/hooks/generate-test/`

**Usage**:
```bash
# Automatic execution on git push
git push origin feature-branch

# Manual execution
./.github/hooks/generate-test/generate-tests.sh

# Preview mode (no files created)
PREVIEW_MODE=true ./.github/hooks/generate-test/generate-tests.sh

# Skip for specific commit
SKIP_TEST_GENERATION=true git commit -m "WIP: experimental"
```

**Configuration** (`.github/hooks/generate-test/hooks.json`):
- `testLanguages`: Supported languages (python, javascript, cpp)
- `outputDir`: Where to save generated tests
- `coverageThreshold`: Minimum test coverage %
- `autoApprove`: Auto-commit generated tests

**Supported Frameworks**:
- Python: pytest
- JavaScript/TypeScript: Jest
- C++: Google Test

**Features**:
- Smart language detection from file extensions
- Test template generation based on detected changes
- Configurable output directory
- Dry-run mode for preview
- Comprehensive logging to `logs/copilot/generation.log`

### update-doc Hook

**Purpose**: Automatically updates documentation based on git diff changes

**Location**: `.github/hooks/update-doc/`

**Usage**:
```bash
# Automatic execution on git push
git push origin feature-branch

# Manual execution
./.github/hooks/update-doc/update-documentation.sh

# Preview mode (no changes applied)
PREVIEW_MODE=true ./.github/hooks/update-doc/update-documentation.sh

# Skip for specific commit
SKIP_DOC_UPDATE=true git commit -m "docs: manual update"
```

**Configuration** (`.github/hooks/update-doc/hooks.json`):
- `updateReadme`: Generate README sections for new features
- `generateChangelog`: Auto-generate CHANGELOG.md entries
- `generateApiDocs`: Create API documentation
- `docDirectory`: Where to store generated docs
- `changelogFile`: Path to CHANGELOG file

**Generates**:
- README.md updates with new features
- CHANGELOG.md entries with date and version
- API documentation (docs/api.md)
- Configuration documentation

**Environment Variables**:
- `UPDATE_README`: Enable/disable README updates
- `GENERATE_CHANGELOG`: Enable/disable changelog generation
- `GENERATE_API_DOCS`: Enable/disable API doc generation
- `PREVIEW_MODE`: Preview changes without applying

## Critical Patterns to Preserve

1. **Idempotent Initialization**: Scripts must check existence before creation (not destructive)
2. **Language Isolation**: Each language template is self-contained; avoid cross-language dependencies
3. **Minimal Configuration**: Use standard tooling (Ruff for Python, Bash for shell) without unnecessary abstraction
4. **Automated CI/CD**: Workflows auto-commit fixes to preserve developer productivity
5. **Directory Naming**: Standard structure (`src/`, `tests/`, `docs/`, `lib/`) across all templates
6. **Hook Conventions**: Kebab-case naming, hooks.json configuration, executable bash scripts
7. **AI Toolset Structure**: Maintain separation between agents, skills, prompts, instructions, and hooks

## Integration Points
- GitHub Actions workflows handle linting and auto-fixes
- Each language template can be extended independently
- Base `initialize_repo.sh` is language-agnostic; language-specific logic lives in dedicated folders
- AI Toolset installation via `./initialize_repo.sh ai-toolset` command
- Hooks integrate with git workflow through `.github/hooks/*/hooks.json` configuration
