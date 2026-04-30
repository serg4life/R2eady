# Code-Setups AI Agent Instructions

## Project Overview
**code-setups** is a multi-language repository scaffolding tool that provides language-specific boilerplate templates and automated initialization scripts for new projects. The project includes base templates for **Bash**, **Python**, and **C++** with corresponding CI/CD workflows and development configurations.

## Architecture & Key Files

### Core Components
- **`initialize_repo.sh`**: Main entry point script that initializes new repositories
  - `init()`: Creates standard directory structure (`src/`, `tests/`, `docs/`, `lib/`)
  - `bare_init()`: Minimal initialization (README.md, .gitignore, Git repo)
  - Supports `--bare` flag for lightweight initialization
  - **Validation**: Always check for `.git` directory existence using `-d` test (not `-f`)

- **Language-Specific Templates**: Each language lives in its own folder (`bash/`, `python/`, `C++/`)
  - Contains README, initialization scripts, configuration files, and CI/CD workflows
  - Python: Includes `pyproject.toml` (Ruff config), `requirements.txt`, and `init_python_project.sh`

### Workflows & CI/CD
Located in `<language>/workflows/`:
- **Python**: `lint_test.yaml` - Ruff linting with auto-fix on push to main/develop
  - Runs on Python 3.12
  - Auto-commits Ruff fixes with bot credentials
  - Permissions: write contents and packages

## Conventions & Patterns

### Initialization Scripts
- Use Bash for all init scripts; follow POSIX compliance for portability
- Always check file/directory existence before creation to avoid overwriting
- Provide user feedback (echo) for each initialization step
- Create `.gitignore` in `bare_init()` with common patterns:
  - `node_modules/`, `.env`, `dist/`, `build/`, `__pycache__/`, `.DS_Store`

### Python Projects
- **Linter**: Ruff with rules `E, W, F, N` (PEP8 errors, warnings, logic errors, naming)
- **Exclusions**: `venv`, `.git`, `__pycache__`
- **Test Framework**: pytest (in requirements.txt)
- **Configuration**: All linting rules in `pyproject.toml` under `[tool.ruff]`

### Git Workflow
- Default branches: `main` and `develop` (created during initialization)
- CI/CD triggers on push to these branches
- Automated bot commits for Ruff fixes use standard GitHub Actions bot identity

## Developer Workflows

### Initialize New Repository
```bash
# Full initialization (creates structure + bare init)
./initialize_repo.sh

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

## Critical Patterns to Preserve

1. **Idempotent Initialization**: Scripts must check existence before creation (not destructive)
2. **Language Isolation**: Each language template is self-contained; avoid cross-language dependencies
3. **Minimal Configuration**: Use standard tooling (Ruff for Python, Bash for shell) without unnecessary abstraction
4. **Automated CI/CD**: Workflows auto-commit fixes to preserve developer productivity
5. **Directory Naming**: Standard structure (`src/`, `tests/`, `docs/`, `lib/`) across all templates

## Integration Points
- GitHub Actions workflows handle linting and auto-fixes
- Each language template can be extended independently
- Base `initialize_repo.sh` is language-agnostic; language-specific logic lives in dedicated folders
