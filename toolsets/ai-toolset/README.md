# AI Toolsets 🤖

A comprehensive collection of GitHub Copilot agents, skills, prompts, instructions, and automation hooks for accelerated software development.

## Overview

This directory contains carefully curated and enhanced resources for GitHub Copilot, including:

- **Agents** (`GENERAL/agents/`): Specialized personas for different development roles
- **Skills** (`GENERAL/skills/`): Reusable AI capabilities for specific tasks
- **Prompts** (`GENERAL/prompts/`): Pre-engineered prompts for common workflows
- **Instructions** (`GENERAL/instructions/`): Custom Copilot behavior guidelines
- **Hooks** (`GENERAL/hooks/`): Git hooks and automation for continuous improvement

## Directory Structure

```
ai-toolset/
├── GENERAL/                    # Primary development resources
│   ├── agents/                 # GitHub Copilot agents
│   ├── skills/                 # Reusable AI skills
│   ├── prompts/                # Pre-built prompts
│   ├── instructions/           # Custom instructions
│   ├── hooks/                  # Automation and git hooks
│   ├── templates/              # Templates for creating new resources
│   ├── ISSUE_TEMPLATE/         # GitHub issue templates
│   └── AGENT-COORDINATION.md   # Agent orchestration documentation
└── GENERATION/                 # Generated/output resources
    ├── instructions/
    └── skills/
```

## Available Agents 👤

| Agent | Purpose | Status |
|-------|---------|--------|
| `debug.agent.md` | Debugging and issue diagnosis | ✅ Production |
| `principal-software-engineer.agent.md` | Architecture and design guidance | ✅ Production |
| `se-security-reviewer.agent.md` | Security code review and OWASP analysis | ✅ Production |
| `se-gitops-ci-specialist.agent.md` | DevOps and CI/CD guidance | ✅ Production |
| `se-performance-reviewer.agent.md` | Performance optimization analysis | ✅ Production |
| `se-technical-writer.agent.md` | Technical documentation writing | ✅ Production |
| `embedded-planner.agent.md` | Embedded systems architecture | ✅ Production |
| `testing-planner.agent.md` | Test strategy and automation | ✅ Production |
| `planner.agent.md` | General implementation planning | ✅ Production |
| `software-engineer-agent-v1.agent.md` | Full-stack engineering | ✅ Production |
| `documentation-planner.agent.md` | Documentation strategy | ✅ Production |

## Available Skills 🎯

### Architecture & Planning
- `create-implementation-plan` - Design and plan new features
- `create-firmware-architecture-plan` - Embedded systems design
- `create-architectural-decision-record` - ADR documentation
- `architecture-blueprint-generator` - Automatic architecture documentation

### Code Quality & Optimization
- `autoresearch` - Autonomous optimization loops
- `refactor` - Surgical code refactoring
- `git-commit` - Conventional commits with AI assistance

### Embedded Systems
- `create-embedded-security-analysis` - Security review for firmware
- `create-embedded-test-strategy` - Testing strategies for embedded code
- `create-memory-optimization-plan` - RAM/ROM optimization

### Development Tools
- `create-readme` - README generation and improvement
- `remember` - Store and recall domain knowledge
- `agentic-eval` - Evaluate and improve AI outputs

### Prompt Engineering & Safety
- `ai-prompt-engineering-safety-review` - Analyze and improve prompts
- `agent-customization` - Create custom agents and instructions

## Available Prompts 📝

| Prompt | Use Case |
|--------|----------|
| `create-agent.prompt.md` | Guide for creating new agents |
| `create-skill.prompt.md` | Guide for creating new skills |
| `create-hook.prompt.md` | Guide for creating new hooks |
| `embedded-planning.prompt.md` | Embedded system architecture planning |
| `embedded-security.prompt.md` | Firmware security analysis |
| `embedded-testing.prompt.md` | Embedded testing strategies |
| `review-agent-coordination.prompt.md` | Multi-agent orchestration review |

## Custom Instructions 📖

Enhanced instructions for specific development tasks:

- `agent-safety.instructions.md` - Safe, governed AI agent systems
- `agent-skills.instructions.md` - High-quality agent skill creation
- `cpp-language-service-tools.instructions.md` - C++ IntelliSense tools
- `instructions.instructions.md` - Creating custom instructions
- `makefile.instructions.md` - GNU Make best practices
- `markdown.instructions.md` - CommonMark formatting
- `performance-optimization.instructions.md` - Optimization techniques
- `prompt.instructions.md` - Prompt file creation
- `self-explanatory-code-commenting.instructions.md` - Code commenting guidelines

## Automation Hooks 🔌

### Git Hooks
- `session-logger/` - Automatic session logging
- `governance-audit/` - Governance and compliance auditing
- `session-auto-commit/` - Automatic commit generation

## Resources Status ⚠️

The following resources need review and validation:
- ✅ `create-memory-optimization-plan` - Reviewed
- ✅ `create-embedded-security-analysis` - Reviewed
- ✅ `create-embedded-test-strategy` - Reviewed
- ✅ `create-firmware-architecture-plan` - Reviewed (note: typo fixed from "architetcture")
- ✅ `autoresearch` - Reviewed
- ✅ `architecture-blueprint-generator` - Reviewed

## Quick Start 🚀

### Using an Agent

1. Specify the agent in your Copilot chat context
2. Mention your development task
3. Follow the agent's guidance

Example:
```
@se-security-reviewer: Review this authentication code for vulnerabilities
```

### Using a Skill

1. Invoke the skill by name in Copilot
2. Provide context and requirements
3. Let the skill guide your work

Example:
```
/create-implementation-plan for adding user authentication
```

### Using Instructions

Instructions are automatically applied to relevant file types in VS Code. They enhance code quality and consistency.

## Integration with VS Code

To use these resources:

1. **Copy to VS Code User Settings**:
   ```bash
   cp -r ai-toolset/GENERAL/* ~/.config/Code/User/
   ```

2. **Or copy to workspace**:
   ```bash
   cp -r ai-toolset/GENERAL/.github/skills .github/
   cp -r ai-toolset/GENERAL/instructions .
   ```

3. **Reference in Copilot Chat**:
   - Type `@agent-name` to use an agent
   - Type `/skill-name` to use a skill
   - Instructions apply automatically

## Creating New Resources

### New Agent
See: `GENERAL/templates/agent-template.agent.md`
Use: `GENERAL/prompts/create-agent.prompt.md`

### New Skill
See: `GENERAL/templates/` and `GENERAL/prompts/create-skill.prompt.md`

### New Hook
See: `GENERAL/templates/hook-template-README.md`
Use: `GENERAL/prompts/create-hook.prompt.md`

## Documentation

- **AGENT-COORDINATION.md**: How agents work together and orchestrate
- Each agent has inline documentation describing its purpose
- Each skill contains usage examples and parameters

## Contributing

To contribute new agents, skills, or prompts:

1. Review existing resources for patterns
2. Use the templates as starting points
3. Test thoroughly with Copilot
4. Document your resource clearly
5. Follow the naming conventions
6. Submit a PR with description

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for more details.

## Sources

These resources are curated from:
- GitHub's Copilot best practices
- Community contributions (awesome-copilot)
- Industry-standard development patterns
- Custom enhancements and improvements

## License

All resources in this directory are provided under the MIT License.
See [LICENSE](../../LICENSE) for details.

---

**Tip**: Start with `principal-software-engineer.agent.md` for architectural guidance and `debug.agent.md` for troubleshooting.

For questions or suggestions, open an issue in the repository.