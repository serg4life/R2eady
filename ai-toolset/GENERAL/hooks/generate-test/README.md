---
name: 'Generate Unit Tests'
description: 'Automatically generates unit tests based on git diff changes using AI analysis'
tags: ['testing', 'automation', 'unit-tests', 'ai-generated']
---

# Generate Unit Tests Hook

Automatically generates unit tests for code changes detected in the git diff. This hook uses AI to analyze modified code and generate comprehensive unit test coverage.

## Overview

This hook:
- Detects changed files in the git diff (staged and unstaged)
- Analyzes code modifications using GitHub Copilot
- Generates relevant unit tests based on the changes
- Creates test files in appropriate directories
- Maintains consistency with existing test patterns

## Features

- **AI-Powered Test Generation**: Uses Copilot to understand code logic and generate tests
- **Smart Language Detection**: Detects language and creates tests in appropriate frameworks
- **Diff Analysis**: Only generates tests for modified code, not entire files
- **Extensible**: Supports Python (pytest), JavaScript/TypeScript (Jest), and C++ (Google Test)
- **Pattern Recognition**: Learns from existing tests to maintain consistency
- **Dry Run Mode**: Preview generated tests before committing

## Installation

1. Copy this hook folder to your repository's `.github/hooks/` directory:
   ```bash
   cp -r hooks/generate-test .github/hooks/
   ```

2. Ensure scripts are executable:
   ```bash
   chmod +x .github/hooks/generate-test/*.sh
   ```

3. Add generated tests directory to `.gitignore` if temporary:
   ```bash
   echo "tests/generated/" >> .gitignore
   ```

4. Commit the hook configuration

## Supported Languages

| Language | Test Framework | File Pattern |
|----------|---|---|
| Python | pytest | `test_*.py` or `*_test.py` |
| JavaScript/TypeScript | Jest | `*.test.js`, `*.test.ts` |
| C++ | Google Test | `*_test.cc` |

## Configuration

Edit `.github/hooks/generate-test/hooks.json` to customize:

```json
{
  "testLanguages": ["python", "javascript", "cpp"],
  "outputDir": "tests/generated",
  "coverageThreshold": 80,
  "includeIntegrationTests": false
}
```

## Usage

The hook automatically runs on:
- `prePush`: Before pushing to remote
- `gitCommitCreated`: After commit creation (if configured)

### Manual Execution

```bash
# Generate tests for current changes
./.github/hooks/generate-test/generate-tests.sh

# Preview without creating files
PREVIEW_MODE=true ./.github/hooks/generate-test/generate-tests.sh

# Disable for specific commit
SKIP_TEST_GENERATION=true git commit -m "message"
```

## Generated Test Examples

### Python (pytest)
```python
# Generated from modified: src/user_service.py
import pytest
from src.user_service import UserService

class TestUserService:
    def test_create_user_valid_input(self):
        service = UserService()
        user = service.create_user({"name": "John", "email": "john@example.com"})
        assert user.name == "John"
    
    def test_create_user_invalid_email(self):
        service = UserService()
        with pytest.raises(ValueError):
            service.create_user({"name": "John", "email": "invalid"})
```

### JavaScript (Jest)
```javascript
// Generated from modified: src/utils.ts
describe('calculateTotal', () => {
  it('should sum all numbers correctly', () => {
    const result = calculateTotal([1, 2, 3]);
    expect(result).toBe(6);
  });

  it('should handle empty arrays', () => {
    const result = calculateTotal([]);
    expect(result).toBe(0);
  });
});
```

## Environment Variables

| Variable | Default | Purpose |
|----------|---------|---------|
| `SKIP_TEST_GENERATION` | `false` | Disable hook execution |
| `PREVIEW_MODE` | `false` | Show generated tests without creating files |
| `TEST_LANGUAGE` | auto-detect | Force specific language |
| `COVERAGE_THRESHOLD` | 80 | Minimum test coverage % required |
| `OUTPUT_DIR` | `tests/generated` | Directory for generated tests |

## Output

Tests are generated in:
- `tests/generated/test_*.py` (Python)
- `tests/generated/*.test.js` (JavaScript)
- `tests/generated/*_test.cc` (C++)

## Integration with CI/CD

The generated tests are automatically included in your CI pipeline:

```yaml
# .github/workflows/test.yml
- name: Run Generated Tests
  run: |
    pytest tests/generated/ -v
```

## Limitations & Best Practices

⚠️ **Generated tests should be reviewed** before merging:
- AI-generated tests may need human refinement
- Edge cases might not be fully covered
- Integration test generation is limited

✅ **Best practices**:
- Review generated tests before committing
- Combine with manual testing for critical paths
- Use as a starting point, not final solution
- Regularly update test patterns in repository

## Troubleshooting

### No tests generated
- Check that files have actual code changes (not just whitespace)
- Verify Copilot is properly configured
- Check `logs/copilot/generation.log` for errors

### Generated tests are incomplete
- Increase `COVERAGE_THRESHOLD` in configuration
- Manually review and enhance generated tests
- Provide examples in existing tests for pattern learning

### Tests fail to run
- Verify test framework is installed
- Check test file syntax
- Review language-specific test execution logs

## Privacy & Performance

- ⏱️ **Timeout**: 30 seconds per file
- 📊 **Performance**: Minimal impact on git workflow
- 🔒 **Security**: Tests analyzed locally, no external calls
- 📝 **Logging**: Generated tests tracked in `logs/copilot/generation.log`

## Examples

### Running hook manually
```bash
cd your-repo
./.github/hooks/generate-test/generate-tests.sh
# Analyzes git diff and generates unit tests
```

### Preview before commit
```bash
PREVIEW_MODE=true ./.github/hooks/generate-test/generate-tests.sh
# Shows what would be generated without creating files
```

### Skip test generation for specific commit
```bash
SKIP_TEST_GENERATION=true git commit -m "WIP: experimental feature"
```

## Support

For issues or questions:
1. Check the logs: `logs/copilot/generation.log`
2. Review hook configuration in `hooks.json`
3. Verify test framework is installed
4. Check GitHub Copilot connectivity
