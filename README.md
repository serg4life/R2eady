# project-configurator 🚀

A powerful, multi-language repository scaffolding tool that accelerates project initialization with production-ready templates, automation, and AI-powered development tools.

## Features ✨

- **Multi-Language Support**: Python, C++, Bash, Docker configurations out of the box
- **Automated Initialization**: One-command setup with sensible defaults
- **CI/CD Ready**: Pre-configured GitHub Actions workflows for each language
- **AI-Powered Toolsets**: Integrated Copilot agents, skills, and prompts for accelerated development
- **Extensible Architecture**: Easy to add new language templates and customizations
- **Production Ready**: Includes linting, testing, and code quality configurations

## Quick Start ⚡

### Installation
```bash
git clone https://github.com/yourusername/project-configurator.git
cd project-configurator
```

### Initialize a New Repository

#### Python Project
```bash
./initialize_repo.sh python
# Creates: src/, tests/, docs/, lib/ + Python configuration
```

#### C++ Project
```bash
./initialize_repo.sh cpp
# Creates: C++ project structure + CMake configuration
```

#### Bash Project
```bash
./initialize_repo.sh bash
# Creates: Bash project structure + shell linting config
```

#### Docker Project
```bash
./initialize_repo.sh docker <container_name>
# Creates: Docker configuration for container development
```

#### AI/Copilot Toolset
```bash
./initialize_repo.sh ia
# Creates: AI agents, skills, prompts, and automation hooks
```

#### Bare Repository (Minimal Setup)
```bash
./initialize_repo.sh --bare
# Creates: Only .gitignore and README.md
```

## Project Structure 📁

```
project-configurator/
├── initialize_repo.sh          # Main entry point for repo initialization
├── Makefile                    # Build and automation tasks
├── python/                     # Python template
│   ├── init_python_project.sh
│   ├── pyproject.toml
│   ├── requirements.txt
│   └── workflows/
│       └── python-lint.yaml   # Ruff linting on CI/CD
├── C++/                        # C++ template
│   ├── CMakeLists.txt
│   └── workflows/
│       └── cpp-lint.yaml
├── bash/                       # Bash template
│   └── README.md
├── docker/                     # Docker template
│   └── README.md
├── ai-toolset/                 # AI/Copilot configuration
│   ├── GENERAL/
│   │   ├── agents/            # Custom Copilot agents
│   │   ├── skills/            # Reusable AI skills
│   │   ├── prompts/           # Pre-built prompts
│   │   ├── instructions/      # Custom instructions
│   │   └── hooks/             # Git hooks and automation
│   └── GENERATION/            # Generated resources
└── logs/                       # Project logs and governance audit
```

## Language Templates 🔧

### Python
- **Linter**: Ruff with PEP8 compliance
- **Testing**: pytest configuration
- **Build**: pyproject.toml with modern Python packaging
- **CI/CD**: Automated linting and auto-fix on GitHub Actions

**Example**:
```bash
./initialize_repo.sh python
cd <new-project>
pip install -r requirements.txt
```

### C++
- **Build**: CMake configuration
- **Linting**: Pre-configured C++ style checks
- **CI/CD**: Automated builds and linting

### Bash
- **Scripting**: Shell script templates
- **Standards**: POSIX compliance configuration

### Docker
- **Container**: Docker development environment setup
- **Orchestration**: Docker Compose ready

## AI Toolsets 🤖

The `ai-toolset/` directory contains a comprehensive collection of:

- **Agents**: Specialized GitHub Copilot agents for debugging, architecture, security, DevOps, and more
- **Skills**: Reusable AI capabilities for code review, refactoring, and analysis
- **Prompts**: Pre-engineered prompts for common development tasks
- **Instructions**: Custom instructions for Copilot behavior and guidelines
- **Hooks**: Git hooks and automation for continuous improvement

### Available Agents
- `debug.agent.md` - Debugging and issue diagnosis
- `principal-software-engineer.agent.md` - Architecture and design guidance
- `se-security-reviewer.agent.md` - Security code review
- `se-gitops-ci-specialist.agent.md` - DevOps and CI/CD guidance
- And more specialized agents for different roles

### Available Skills
- `create-implementation-plan` - Feature planning and design
- `create-firmware-architecture-plan` - Embedded systems design
- `autoresearch` - Autonomous optimization loops
- `create-readme` - README generation
- `git-commit` - Conventional commits with AI assistance
- And more...

For detailed information, see [ai-toolset/README.md](ai-toolset/README.md).

## Configuration 🔨

### Environment Variables
```bash
# Optional: Set custom config directory
export CONFIG_DIR="/custom/config/path"

# Optional: Set container directory
export CONTAINERS_DIR="/custom/containers"
```

### Python-Specific Options
The Python template uses Ruff for linting with the following rules:
- `E, W` - PEP8 errors and warnings
- `F` - PyFlakes (logic errors)
- `N` - Naming conventions

Configured in `pyproject.toml`:
```toml
[tool.ruff]
exclude = ["venv", ".git", "__pycache__"]
```

## CI/CD Workflows 🔄

Each language includes pre-configured GitHub Actions workflows:

### Python
- Runs on: Python 3.12
- Tasks: Linting, auto-fix with Ruff
- Trigger: Push to main/develop branches
- Auto-commits fixes using bot credentials

### C++
- Tasks: Build validation, linting
- Platforms: Multiple compiler support

All workflows follow GitHub Actions best practices with proper permissions and security configurations.

## Usage Examples 📚

### Create a Python Project with Type Hints and Tests
```bash
./initialize_repo.sh python
cd my-python-project
python -m pytest tests/
ruff check . --fix
```

### Create a C++ Embedded System Project
```bash
./initialize_repo.sh cpp
cd my-embedded-project
mkdir -p build
cd build
cmake ..
make
```

### Initialize a Project with AI Toolsets
```bash
./initialize_repo.sh ia
cd my-ai-project
# Access custom agents, skills, and prompts for development
```

## Contributing 🤝

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for:
- How to add new language templates
- Guidelines for contributing agents and skills
- Code style and conventions
- Testing requirements

## Repository Resources 📖

The project includes extensive documentation:

- **README files**: Each template directory has its own README
- **Instructions**: Custom guidelines for code quality and development
- **Templates**: Reusable patterns for agents, skills, and hooks
- **Examples**: Working examples in each language template

## Support 💡

For issues and questions:
1. Check existing documentation in the template directories
2. Review the [Issues](https://github.com/yourusername/project-configurator/issues) page
3. Create a new issue with detailed information

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 🙏

This project incorporates resources and patterns from:
- The awesome-copilot community
- GitHub's best practices for repositories
- Industry-standard templates and workflows

---

**Made with ❤️ for developers who value automation and consistency**

[⬆ Back to top](#project-configurator-)