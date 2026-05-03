---
name: 'Update Documentation'
description: 'Automatically generates and updates repository documentation based on git diff changes'
tags: ['documentation', 'automation', 'markdown', 'ai-generated']
---

# Update Documentation Hook

Automatically generates and updates repository documentation based on code changes detected in the git diff. This hook uses AI to analyze modified code and generate relevant documentation updates.

## Overview

This hook:
- Detects changed files in the git diff
- Analyzes code modifications and their purpose
- Generates documentation updates automatically
- Updates API documentation, README sections, and change logs
- Maintains documentation consistency and completeness

## Features

- **AI-Powered Documentation**: Uses Copilot to understand code and generate docs
- **Multi-Format Support**: Updates README.md, API docs, and CHANGELOG
- **Smart Detection**: Identifies new functions, classes, and APIs
- **Pattern Learning**: Learns from existing documentation style
- **Change Tracking**: Maintains CHANGELOG.md automatically
- **Dry Run Mode**: Preview documentation changes before committing

## Installation

1. Copy this hook folder to your repository's `.github/hooks/` directory:
   ```bash
   cp -r hooks/update-doc .github/hooks/
   ```

2. Ensure scripts are executable:
   ```bash
   chmod +x .github/hooks/update-doc/*.sh
   ```

3. Initialize documentation structure (optional):
   ```bash
   mkdir -p docs
   touch CHANGELOG.md README.md
   ```

4. Commit the hook configuration

## Supported Documentation Types

| Type | File | Purpose |
|------|------|---------|
| API Reference | `docs/api.md` | Auto-generated API documentation |
| Changelog | `CHANGELOG.md` | Versioned changes and updates |
| README | `README.md` | Project overview and quick start |
| Architecture | `docs/architecture.md` | System design and structure |
| Configuration | `docs/configuration.md` | Setup and configuration guide |

## Configuration

Edit `.github/hooks/update-doc/hooks.json` to customize:

```json
{
  "updateReadme": true,
  "generateChangelog": true,
  "generateApiDocs": true,
  "docDirectory": "docs",
  "changelogFile": "CHANGELOG.md",
  "autoCommit": false,
  "detectionThreshold": 0.7
}
```

## Usage

The hook automatically runs on:
- `prePush`: Before pushing to remote
- `gitCommitCreated`: After commit creation (if configured)

### Manual Execution

```bash
# Update documentation for current changes
./.github/hooks/update-doc/update-documentation.sh

# Preview without making changes
PREVIEW_MODE=true ./.github/hooks/update-doc/update-documentation.sh

# Disable for specific commit
SKIP_DOC_UPDATE=true git commit -m "message"
```

## Generated Documentation Examples

### README Section Update
```markdown
## New Features

### User Authentication Module
- Secure login/logout functionality
- JWT token management
- Password reset capability
- Multi-factor authentication support

**Usage Example:**
\`\`\`python
from auth import UserAuthenticator
auth = UserAuthenticator()
token = auth.login(username, password)
\`\`\`
```

### API Documentation
```markdown
## API Reference

### UserService

#### `create_user(name: str, email: str) -> User`
Create a new user in the system.

**Parameters:**
- `name` (str): User's full name
- `email` (str): User's email address

**Returns:**
- User object with generated ID

**Raises:**
- ValueError: If email format is invalid
- DuplicateUserError: If email already exists

**Example:**
\`\`\`python
user = service.create_user("John Doe", "john@example.com")
\`\`\`
```

### Changelog Entry
```markdown
## [1.2.0] - 2024-05-02

### Added
- New user authentication module
- JWT token-based session management
- Password reset functionality
- Multi-factor authentication support

### Changed
- Updated user model schema
- Improved error handling in auth service

### Fixed
- Session timeout issues
- Email validation edge cases

### Security
- Added rate limiting to login endpoint
- Implemented secure password hashing
```

## Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `SKIP_DOC_UPDATE` | `false` | Disable hook execution |
| `PREVIEW_MODE` | `false` | Show changes without applying |
| `UPDATE_README` | `true` | Generate README updates |
| `GENERATE_CHANGELOG` | `true` | Generate CHANGELOG entries |
| `GENERATE_API_DOCS` | `true` | Generate API documentation |
| `DOC_DIRECTORY` | `docs` | Documentation directory path |
| `CHANGELOG_FILE` | `CHANGELOG.md` | Changelog file path |

## Output Files

Documentation updates are applied to:
- `README.md` - Project overview sections
- `CHANGELOG.md` - Version entries with changes
- `docs/api.md` - API reference documentation
- `docs/architecture.md` - System design updates
- `docs/configuration.md` - Setup instructions

## Integration with CI/CD

Documentation builds are included in your CI workflow:

```yaml
# .github/workflows/docs.yml
- name: Build Documentation
  run: |
    mdbook build
    # or
    sphinx-build -b html docs docs/_build
```

## Supported Change Types

The hook detects and documents:

✅ **New Functions/Methods**
- Function signature and parameters
- Return types and exceptions
- Usage examples
- Integration points

✅ **New Classes/Types**
- Class hierarchy and relationships
- Properties and methods
- Initialization parameters
- Usage patterns

✅ **Configuration Changes**
- New configuration options
- Default values
- Environment variables
- Validation rules

✅ **API Endpoints** (for REST APIs)
- HTTP method and path
- Request/response schemas
- Authentication requirements
- Error responses

## Best Practices

⚠️ **Always review generated documentation**:
- Verify accuracy of examples
- Check completeness of descriptions
- Update auto-generated content as needed
- Ensure consistency with existing docs

✅ **Recommendations**:
- Keep documentation with code changes
- Use descriptive commit messages for docs
- Review generated sections carefully
- Update manually when needed
- Test documentation examples

## Troubleshooting

### No documentation generated
- Check that files have actual API changes
- Verify Copilot is properly configured
- Check `logs/copilot/documentation.log` for errors
- Ensure changelog file exists

### Documentation is incomplete
- Review change complexity
- Manually enhance auto-generated sections
- Provide examples in code comments for pattern learning
- Check detection threshold

### Formatting issues
- Verify markdown formatting
- Check file encoding (UTF-8)
- Review existing documentation style
- Check for conflicting auto-formatting tools

## Performance & Limits

- ⏱️ **Timeout**: 30 seconds per documentation batch
- 📄 **Max files**: Up to 100 changed files per run
- 💾 **Cache**: Learning from 10 most recent documented changes
- 📊 **Size limit**: Generated documentation limited to 10KB per section

## Examples

### Manual documentation update
```bash
cd your-repo
./.github/hooks/update-doc/update-documentation.sh
# Analyzes changes and updates documentation
```

### Preview documentation changes
```bash
PREVIEW_MODE=true ./.github/hooks/update-doc/update-documentation.sh
# Shows what would be updated
```

### Skip documentation for WIP commit
```bash
SKIP_DOC_UPDATE=true git commit -m "WIP: experimental feature"
```

### Force specific documentation type
```bash
UPDATE_README=true GENERATE_CHANGELOG=true GENERATE_API_DOCS=false \
  ./.github/hooks/update-doc/update-documentation.sh
```

## Integration Examples

### Monorepo Support
```bash
# Update docs for specific package
DOC_DIRECTORY=packages/auth/docs \
  ./.github/hooks/update-doc/update-documentation.sh
```

### Custom Changelog Format
The hook adapts to your existing CHANGELOG format (Semantic Versioning, Keep a Changelog, etc.)

## Privacy & Security

- 🔒 **Local Processing**: All analysis done locally
- 📝 **Logging**: Changes tracked in `logs/copilot/documentation.log`
- 🔐 **No External Calls**: Documentation generated without cloud services
- 📊 **Sensitive Data**: Be careful with sensitive code in documentation

## Support

For issues or questions:
1. Check the logs: `logs/copilot/documentation.log`
2. Review hook configuration in `hooks.json`
3. Verify documentation files are writable
4. Check GitHub Copilot connectivity
5. Review examples in this README
