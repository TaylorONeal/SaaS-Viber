# Contributing to [YOUR_PROJECT]

First off, thank you for considering contributing to [YOUR_PROJECT]! It's people like you that make [YOUR_PROJECT] such a great tool.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Development Setup](#development-setup)
- [Code Style Guidelines](#code-style-guidelines)
- [Commit Message Conventions](#commit-message-conventions)
- [Pull Request Process](#pull-request-process)
- [Issue Guidelines](#issue-guidelines)
- [Community](#community)

## Code of Conduct

This project and everyone participating in it is governed by the [YOUR_PROJECT] Code of Conduct. By participating, you are expected to uphold this code. Please report unacceptable behavior to [YOUR_CONTACT_EMAIL].

See [CODE_OF_CONDUCT.md](./CODE_OF_CONDUCT.md) for details.

## How Can I Contribute?

### Reporting Bugs

Before creating a bug report, please check existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title** for the issue
- **Describe the exact steps to reproduce the problem**
- **Provide specific examples** — include links, snippets, or screenshots
- **Describe the behavior you observed** and what you expected
- **Include your environment details** (OS, browser, Node version, etc.)

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description** of the suggested enhancement
- **Explain why this enhancement would be useful** to most users
- **List any alternative solutions** you've considered

### Your First Code Contribution

Unsure where to begin? Look for issues tagged with:

- `good first issue` — simple issues good for newcomers
- `help wanted` — issues that need community attention
- `documentation` — improvements to docs are always welcome

### Discussions

Use [GitHub Discussions](https://github.com/[YOUR_ORG]/[YOUR_PROJECT]/discussions) for:

- Questions about the project
- Ideas that aren't yet concrete enough for an issue
- Showing off what you've built with [YOUR_PROJECT]
- General community conversation

## Development Setup

### Prerequisites

- Node.js [YOUR_NODE_VERSION] or higher
- npm / yarn / pnpm (we use [YOUR_PACKAGE_MANAGER])
- Git
- [ANY_OTHER_PREREQUISITES]

### Getting Started

```bash
# 1. Fork the repository on GitHub

# 2. Clone your fork
git clone https://github.com/YOUR_USERNAME/[YOUR_PROJECT].git
cd [YOUR_PROJECT]

# 3. Add upstream remote
git remote add upstream https://github.com/[YOUR_ORG]/[YOUR_PROJECT].git

# 4. Install dependencies
npm install

# 5. Copy environment variables
cp .env.example .env.local

# 6. Start development server
npm run dev

# 7. Run tests to verify setup
npm test
```

### Project Structure

```
[YOUR_PROJECT]/
├── src/
│   ├── components/    # React components
│   ├── hooks/         # Custom hooks
│   ├── lib/           # Utilities
│   ├── pages/         # Page components
│   └── types/         # TypeScript types
├── public/            # Static assets
├── supabase/          # Database migrations and functions
├── tests/             # Test files
└── docs/              # Documentation
```

## Code Style Guidelines

### General Principles

- Write TypeScript, not JavaScript — no `any` types
- Prefer functional components and hooks
- Keep functions small and focused
- Write self-documenting code; add comments only for "why," not "what"

### Formatting

We use automated formatting to keep code consistent:

```bash
# Format code
npm run format

# Lint code
npm run lint

# Type check
npm run typecheck
```

- **Indentation**: 2 spaces
- **Quotes**: Single quotes for JS/TS, double quotes for JSX attributes
- **Semicolons**: [YES/NO — pick your convention]
- **Trailing commas**: ES5-compatible (objects, arrays, function params)
- **Line length**: 100 characters max

### Naming Conventions

| Element | Convention | Example |
|---------|-----------|---------|
| Components | PascalCase | `UserProfile.tsx` |
| Hooks | camelCase with `use` prefix | `useAuth.ts` |
| Utilities | camelCase | `formatDate.ts` |
| Types/Interfaces | PascalCase | `UserProfile` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| CSS classes | kebab-case (Tailwind) | `text-primary` |
| Database tables | snake_case | `org_members` |
| Database columns | snake_case | `created_at` |

### File Organization

- One component per file
- Co-locate tests: `Component.tsx` + `Component.test.tsx`
- Co-locate types when component-specific
- Use barrel exports (`index.ts`) per feature folder

## Commit Message Conventions

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer(s)]
```

### Types

| Type | Description |
|------|-------------|
| `feat` | A new feature |
| `fix` | A bug fix |
| `docs` | Documentation only changes |
| `style` | Formatting, missing semicolons, etc. (no code change) |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `perf` | Performance improvement |
| `test` | Adding or correcting tests |
| `chore` | Changes to build process or auxiliary tools |
| `ci` | Changes to CI configuration |

### Examples

```
feat(auth): add Google OAuth login
fix(dashboard): correct chart rendering on mobile
docs(readme): update installation instructions
refactor(hooks): extract shared pagination logic
```

### Rules

- Use the imperative mood ("add feature" not "added feature")
- Don't capitalize the first letter of the description
- No period at the end of the description
- Reference issues in the footer: `Closes #123`

## Pull Request Process

### Before Submitting

1. **Create a branch** from `main` (or the appropriate base branch):
   ```bash
   git checkout -b feat/my-feature
   ```

2. **Make your changes** following our code style guidelines

3. **Write or update tests** for your changes

4. **Run the full check suite**:
   ```bash
   npm run lint
   npm run typecheck
   npm test
   npm run build
   ```

5. **Update documentation** if your change affects it

### Submitting

1. Push your branch to your fork
2. Open a Pull Request against the `main` branch of the upstream repo
3. Fill in the PR template completely
4. Link any related issues

### PR Template

When you open a PR, please include:

```markdown
## Summary
<!-- What does this PR do? -->

## Type of Change
- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that would cause existing functionality to not work)
- [ ] Documentation update

## Testing
<!-- How did you test this? -->
- [ ] Unit tests pass
- [ ] Integration tests pass
- [ ] Manual testing completed

## Screenshots (if applicable)

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review of my code
- [ ] I have commented my code, particularly in hard-to-understand areas
- [ ] I have made corresponding changes to the documentation
- [ ] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or my feature works
```

### Review Process

1. At least [1/2] maintainer(s) must approve the PR
2. All CI checks must pass
3. The branch must be up to date with `main`
4. Conversations must be resolved before merging
5. We use **squash and merge** for most PRs

### After Merging

- Delete your branch
- Check that the change works in the staging/preview environment
- Close related issues if not auto-closed

## Issue Guidelines

### Bug Report Template

```markdown
**Describe the bug**
A clear description of what the bug is.

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

**Expected behavior**
What you expected to happen.

**Screenshots**
If applicable, add screenshots.

**Environment:**
- OS: [e.g., macOS 14.0]
- Browser: [e.g., Chrome 120]
- Version: [e.g., 1.2.3]
```

### Feature Request Template

```markdown
**Is your feature request related to a problem?**
A clear description of the problem. Ex: "I'm always frustrated when..."

**Describe the solution you'd like**
A clear description of what you want to happen.

**Describe alternatives you've considered**
Other solutions or features you've considered.

**Additional context**
Any other context or screenshots about the feature request.
```

## Community

- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: Questions, ideas, and community chat
- **[YOUR_CHAT_PLATFORM]**: [Link to Discord/Slack if applicable]
- **[YOUR_TWITTER/X]**: Follow us at [@YOUR_HANDLE]

## Recognition

Contributors are recognized in our [CONTRIBUTORS.md](./CONTRIBUTORS.md) file and release notes. We appreciate every contribution, no matter how small!

---

Thank you for contributing to [YOUR_PROJECT]!
