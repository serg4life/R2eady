# Contributing to project-configurator 🤝

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to project-configurator.

## Code of Conduct

Be respectful, inclusive, and professional. We're building a community where everyone feels welcome.

## How to Contribute

### Reporting Issues

Found a bug or have a suggestion? Please [open an issue](https://github.com/yourusername/project-configurator/issues) with:

1. **Clear title**: Describe the issue concisely
2. **Detailed description**: Explain what happened and what you expected
3. **Steps to reproduce**: Include minimal reproduction steps for bugs
4. **Environment**: Python version, OS, etc.
5. **Screenshots**: If applicable, include visual evidence

### Suggesting Enhancements

Have an idea for improvement? Please:

1. Create an issue with the `enhancement` label
2. Describe the use case and expected behavior
3. Explain why this enhancement would be useful
4. Provide examples if possible

### Contributing Code

#### Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/yourusername/project-configurator.git`
3. Create a feature branch: `git checkout -b feature/your-feature-name`
4. Make your changes
5. Test thoroughly
6. Commit with conventional commits (see below)
7. Push to your fork
8. Open a Pull Request

#### Code Style

- **Shell Scripts** (`.sh`): POSIX-compliant, properly quoted variables, clear comments
- **Python**: Follow PEP8, use Ruff linting, include type hints where practical
- **C++**: Follow the CMake conventions, clean and documented code
- **Comments**: Use self-explanatory code; comment only WHY, not WHAT

#### Git Workflow

**Conventional Commits**: Use the following format:

```
type(scope): description

[optional body]
[optional footer]
```

**Types**:
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style changes (formatting, semicolons, etc.)
- `refactor` - Code refactoring without new features
- `test` - Adding or updating tests
- `chore` - Maintenance tasks, dependencies

**Examples**:
```
feat(python): add pytest configuration to Python template
fix(bash): correct variable quoting in init script
docs: update README with installation instructions
```

#### Testing Requirements

Before submitting a PR:

1. **Shell Scripts**: Test on multiple shells if possible
   ```bash
   # Test initialization
   ./initialize_repo.sh python
   ./initialize_repo.sh --bare
   ```

2. **Python**: Run linting
   ```bash
   ruff check .
   ```

3. **Documentation**: Verify links and formatting
   ```bash
   # Check markdown for broken links
   ```

#### Pull Request Process

1. **Update documentation** if you're changing functionality
2. **Add tests** if applicable
3. **Update CHANGELOG** (if exists) with your changes
4. **Reference any related issues** in your PR description
5. **Request review** from maintainers
6. **Address feedback** promptly

**PR Title Format**:
```
[TYPE] Brief description of changes
```

**PR Description Template**:
```markdown
## Description
Brief description of what this PR does.

## Type of Change
- [ ] Bug fix (fixes issue #...)
- [ ] New feature (closes #...)
- [ ] Documentation update
- [ ] Other (specify)

## Related Issues
Closes #123

## Testing
How did you test this change?

## Checklist
- [ ] My code follows the style guidelines
- [ ] I have commented my code where necessary
- [ ] I have updated the documentation
- [ ] My changes generate no new warnings
```

### Adding a New Language Template

1. Create directory: `mkdir <language>/`
2. Add template files:
   - `README.md` - Template-specific documentation
   - `init_<language>_project.sh` - Initialization script
   - Configuration files (e.g., `pyproject.toml`, `CMakeLists.txt`)
   - `workflows/` - GitHub Actions workflows

3. Update root `initialize_repo.sh`:
   - Add case statement for your language
   - Update help text
   - Implement initialization function

4. Update root README.md with new language instructions

5. Test thoroughly:
   ```bash
   ./initialize_repo.sh <language>
   ```

### Adding a New Agent/Skill

1. Review existing agents/skills in `ai-toolset/GENERAL/`
2. Use the templates: `ai-toolset/GENERAL/templates/`
3. Follow the specified format and structure
4. Test with GitHub Copilot
5. Document in `ai-toolset/README.md`
6. Add to appropriate category

### Documentation Guidelines

- Use clear, concise language
- Include examples where helpful
- Keep README files up-to-date
- Link between related documents
- Add table of contents for long documents
- Use proper markdown formatting

## Project Structure

```
project-configurator/
├── <language>/          # Language templates
├── ai-toolset/          # AI resources
├── logs/                # Logs and audit trails
├── initialize_repo.sh   # Main entry point
├── README.md            # Project documentation
├── CONTRIBUTING.md      # This file
├── LICENSE              # License file
└── Makefile            # Build automation
```

## Development Setup

### Local Testing

```bash
# Clone and navigate
git clone <your-fork>
cd project-configurator

# Test Python template
./initialize_repo.sh python test-python
cd test-python
pip install -r requirements.txt

# Test bare initialization
./initialize_repo.sh --bare

# Test other templates
./initialize_repo.sh cpp
./initialize_repo.sh bash
```

### Useful Commands

```bash
# Check all shell scripts
shellcheck initialize_repo.sh bash/*.sh

# Run Python linting
ruff check .

# View git log with proper formatting
git log --oneline --graph
```

## Commit Message Checklist

- [ ] Type is appropriate (feat, fix, docs, etc.)
- [ ] Scope is clear and relevant
- [ ] Description is concise and imperative
- [ ] Related issues are mentioned
- [ ] No typos or grammatical errors

## Review Process

1. **Automated checks** run on all PRs
2. **Maintainer review** provides feedback
3. **Requested changes** should be addressed
4. **Approval** from at least one maintainer
5. **Merge** to main branch

## Questions?

- Check existing [Issues](https://github.com/yourusername/project-configurator/issues)
- Review [Discussions](https://github.com/yourusername/project-configurator/discussions)
- Ask in PRs or issues - we're here to help!

## Recognition 🌟

Contributors will be recognized in:
- Git history (automatic)
- README.md contributors section (as appropriate)

---

Thank you for contributing to project-configurator! 🚀
