# AI Coding Assistant Onboarding Guide

> Template for onboarding an AI coding assistant to your SaaS project.
> Fill in the bracketed sections with your project specifics.

---

## 1. Project Overview (Share First)

Before any coding task, provide your AI assistant with:

```
Project: [YOUR_PROJECT_NAME]
Stack: [e.g., Next.js 14 / TypeScript / Supabase / Stripe / Tailwind CSS]
Architecture: [e.g., Monorepo, App Router, Server Components]
Stage: [e.g., MVP, Beta, Production]
```

### Key Context Files to Share

Share these files in order of priority:

1. **`package.json`** -- dependencies, scripts, project name
2. **`tsconfig.json`** -- TypeScript configuration and path aliases
3. **`docs/ai-agents/KEY_FILES.md`** -- full project file index
4. **`docs/ai-agents/DESIGN_SYSTEM.md`** -- design tokens and component patterns
5. **`docs/ai-agents/LESSONS_LEARNED.md`** -- known pitfalls to avoid
6. **Database schema file** -- table definitions and relationships
7. **`.env.example`** -- environment variable structure (never share actual secrets)

---

## 2. Context Loading Strategy

### Session Start (Every New Conversation)

```markdown
I'm working on [PROJECT_NAME], a SaaS application built with [STACK].
Here's the current file structure: [paste tree output or KEY_FILES.md]
Today I need to work on: [specific task]
```

### For Feature Work

```markdown
Feature: [name]
Related files: [list 3-5 files]
Database tables involved: [list tables]
Current behavior: [what exists]
Desired behavior: [what you want]
```

### For Bug Fixes

```markdown
Bug: [description]
Steps to reproduce: [1, 2, 3]
Expected: [what should happen]
Actual: [what happens instead]
Error messages: [paste errors]
Related files: [list files]
```

---

## 3. Common Tasks and How to Prompt

### Create a New Feature

```
Create a [feature name] that allows users to [action].
Requirements:
- [requirement 1]
- [requirement 2]
Follow the existing patterns in [reference file].
Use the design tokens from our design system.
Include proper TypeScript types and error handling.
```

### Create a New API Endpoint

```
Create a [METHOD] /api/[path] endpoint that:
- Accepts: [request body/params]
- Validates: [validation rules]
- Returns: [response shape]
- Auth: [required/optional/public]
Follow the pattern in [existing endpoint file].
Include proper error responses and status codes.
```

### Database Changes

```
I need to add [table/column/index] to support [feature].
Current schema: [paste relevant schema]
Relationships: [describe foreign keys]
Generate the migration and update the TypeScript types.
```

### Write Tests

```
Write tests for [module/component/endpoint].
Test these scenarios:
- Happy path: [description]
- Edge case: [description]
- Error case: [description]
Follow the testing patterns in [existing test file].
```

### Refactor Code

```
Refactor [file/module] to:
- [improvement 1]
- [improvement 2]
Preserve all existing behavior. Current tests: [location].
Explain each change and why it improves the code.
```

---

## 4. Pitfalls When Using AI for SaaS Development

### Security Pitfalls

- **Never paste real API keys or secrets** -- use placeholders
- **Always review auth logic manually** -- AI may miss authorization edge cases
- **Validate AI-generated SQL** -- check for injection vulnerabilities
- **Review webhook handlers** -- ensure proper signature verification

### Code Quality Pitfalls

- **AI may not know your conventions** -- always reference existing patterns
- **Generated code may import nonexistent packages** -- verify all imports
- **Type definitions may be incomplete** -- check for `any` types slipping in
- **AI tends to over-engineer** -- ask for the simplest solution first

### Architecture Pitfalls

- **AI lacks full project context** -- always share related files
- **Generated code may duplicate existing utilities** -- point to shared helpers
- **State management choices may conflict** -- specify your approach
- **API design may not follow your conventions** -- share API examples

### Data Pitfalls

- **AI may generate insecure default RLS policies** -- always review
- **Migration scripts may not handle existing data** -- test with real data
- **AI may not account for soft deletes** -- specify your deletion strategy
- **Timezone handling is often wrong** -- specify UTC-first approach

---

## 5. Project-Specific Configuration

> Fill in these sections for your project:

### Architecture Decisions

```
Routing: [App Router / Pages Router / etc.]
Data Fetching: [Server Components / SWR / React Query / etc.]
State Management: [Zustand / Context / Redux / etc.]
Form Handling: [React Hook Form / Formik / etc.]
Validation: [Zod / Yup / etc.]
```

### Naming Conventions

```
Components: [PascalCase / kebab-case files]
API Routes: [convention]
Database Tables: [snake_case / camelCase]
CSS Classes: [Tailwind / CSS Modules / etc.]
```

### File Organization

```
Components: [path pattern]
Pages: [path pattern]
API Routes: [path pattern]
Utilities: [path pattern]
Types: [path pattern]
```

---

## 6. Quick Reference Prompts

| Task | Prompt Prefix |
|------|--------------|
| New component | "Create a React component following our design system..." |
| New endpoint | "Create an API route following the pattern in..." |
| Database change | "Generate a migration to..." |
| Bug fix | "Debug this issue. Error: ... Files involved: ..." |
| Test writing | "Write tests for [file] covering..." |
| Code review | "Review this code for security, performance, and patterns..." |
| Refactor | "Refactor [file] to improve [aspect] while preserving behavior..." |
| Documentation | "Document the [module] API following our doc format..." |

---

## 7. Keeping This Guide Updated

- Update `KEY_FILES.md` whenever you add significant new files
- Add new lessons to `LESSONS_LEARNED.md` after resolving tricky bugs
- Update `DESIGN_SYSTEM.md` when design tokens or components change
- Review this guide monthly to ensure accuracy
