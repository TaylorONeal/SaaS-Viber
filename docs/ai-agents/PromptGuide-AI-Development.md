# AI-Assisted Development Prompt Guide

> Master prompt templates for using AI throughout the SaaS development lifecycle.
> Copy, customize, and paste these into your AI assistant conversations.

---

## 1. Set Up Project Context for AI Assistant

Use this at the start of every session to ground the AI in your project.

```
I'm building [PROJECT_NAME], a SaaS application for [TARGET_AUDIENCE] that
helps them [VALUE_PROPOSITION].

Tech stack:
- Framework: [Next.js 14 / App Router]
- Language: TypeScript (strict mode)
- Database: [Supabase / PostgreSQL]
- Auth: [Supabase Auth / NextAuth / Clerk]
- Payments: [Stripe]
- Styling: [Tailwind CSS + shadcn/ui]
- Deployment: [Vercel / AWS / etc.]

Key conventions:
- [List 3-5 coding conventions]

Current task: [What you need to do]
Related files: [List relevant files]
```

---

## 2. Generate Component from Design Description

```
Create a React component based on this design description:

Component name: [ComponentName]
Location: [file path]

Visual description:
- [Describe the layout, colors, spacing]
- [Describe interactive states: hover, focus, disabled]
- [Describe responsive behavior]

Props:
- [prop: type - description]
- [prop: type - description]

Requirements:
- Use Tailwind CSS for styling
- Use our design tokens from [design system file]
- Follow the component pattern in [reference component]
- Include TypeScript types for all props
- Support dark mode via data-theme attribute
- Make it accessible (ARIA labels, keyboard navigation)

Example usage:
<ComponentName prop1="value" prop2={value} />
```

---

## 3. Debug a Complex Issue

```
I have a bug I need help debugging.

Symptom: [What's going wrong -- be specific]

Steps to reproduce:
1. [Step 1]
2. [Step 2]
3. [Step 3]

Expected behavior: [What should happen]
Actual behavior: [What actually happens]

Error messages/logs:
```
[Paste error output here]
```

Environment: [Browser, OS, Node version, etc.]

What I've tried:
- [Attempted fix 1 and result]
- [Attempted fix 2 and result]

Relevant code:
[Paste the relevant code sections]

Related files: [List files that might be involved]

Please:
1. Analyze the root cause
2. Explain why it's happening
3. Provide a fix with code
4. Suggest how to prevent this class of bug
```

---

## 4. Refactor for Performance

```
I need to optimize [file/module/component] for performance.

Current behavior:
- [Describe what it does]
- [Current performance metrics if available]

Performance issue:
- [Describe the slowness, re-renders, memory usage, etc.]

Here's the current code:
[Paste the code]

Constraints:
- Must preserve all existing behavior
- Must maintain TypeScript strict mode compliance
- Tests are located at [test file path]
- Must remain readable and maintainable

Please:
1. Identify specific performance bottlenecks
2. Propose optimizations ranked by impact
3. Implement the changes
4. Explain the performance gain for each change
5. Note any tradeoffs
```

---

## 5. Generate Tests for a Module

```
Write comprehensive tests for [module/component/function].

File to test: [file path]
Test file location: [test file path]
Test framework: [Vitest / Jest / Playwright]

Here's the code to test:
[Paste the code]

Dependencies to mock:
- [Dependency 1]: [How to mock it]
- [Dependency 2]: [How to mock it]

Test scenarios to cover:
1. Happy path: [description]
2. Edge cases:
   - [empty input]
   - [maximum values]
   - [null/undefined handling]
3. Error cases:
   - [network failure]
   - [invalid input]
   - [unauthorized access]
4. Integration:
   - [interaction with other modules]

Follow the testing patterns in [existing test file].
Use [factory/fixture] for test data.
Each test should have a descriptive name explaining the scenario.
```

---

## 6. Review Code for Security Issues

```
Review the following code for security vulnerabilities.

Context: This code handles [describe what it does -- auth, payments, user data, etc.]

[Paste the code]

Check specifically for:
- [ ] SQL injection / query injection
- [ ] XSS (cross-site scripting) vulnerabilities
- [ ] CSRF protection
- [ ] Authentication bypass
- [ ] Authorization flaws (can users access others' data?)
- [ ] Sensitive data exposure (logging secrets, returning too much data)
- [ ] Input validation gaps
- [ ] Rate limiting needs
- [ ] Insecure defaults
- [ ] Dependency vulnerabilities

For each issue found:
1. Severity: Critical / High / Medium / Low
2. Description of the vulnerability
3. Attack scenario
4. Recommended fix with code
```

---

## 7. Generate Database Migration

```
I need a database migration for the following change:

Current schema (relevant tables):
[Paste current schema or describe current state]

Required change:
- [Describe what needs to change]

Requirements:
- Migration must be reversible (include rollback)
- Handle existing data appropriately
- Add appropriate indexes
- Set up RLS policies for new tables
- Use [timestamptz] for all date fields
- Include NOT NULL constraints where appropriate
- Add foreign key constraints with appropriate ON DELETE behavior

Naming convention: [snake_case / camelCase]
Migration tool: [Supabase migrations / Prisma / Drizzle / raw SQL]

Please generate:
1. The forward migration
2. The rollback migration
3. Updated TypeScript types
4. Any seed data needed for development
5. RLS policies for the new tables/columns
```

---

## 8. Create API Endpoint from PRD

```
Create an API endpoint based on this product requirement:

Feature: [Feature name]
Description: [What this endpoint enables]

Endpoint: [METHOD] /api/[path]

Authentication: [Required / Optional / Public]
Authorization: [Who can access -- roles, ownership rules]

Request:
- Method: [GET / POST / PUT / PATCH / DELETE]
- Headers: [Any required headers]
- Body/Params:
  ```json
  {
    "field1": "type - description",
    "field2": "type - description"
  }
  ```

Response (success):
  ```json
  {
    "data": { ... },
    "message": "string"
  }
  ```

Response (errors):
- 400: [When / why]
- 401: [When / why]
- 403: [When / why]
- 404: [When / why]
- 500: [When / why]

Business rules:
1. [Rule 1]
2. [Rule 2]

Rate limiting: [requests per minute]

Follow the API pattern in [existing endpoint file].
Include:
- Input validation with [Zod / etc.]
- Proper error handling and status codes
- TypeScript types for request and response
- Audit logging if the action modifies data
```

---

## Tips for Effective AI Prompting

1. **Be specific** -- "Fix this bug" is worse than "This function returns null when the user has no subscription because the optional chain stops at..."
2. **Show context** -- Always paste the actual code, not just a description
3. **State constraints** -- Mention your stack, conventions, and patterns
4. **Ask for explanation** -- "Explain why" produces better code than "just fix it"
5. **Iterate** -- If the first result is close but not right, explain what needs to change rather than reprompting from scratch
6. **Verify** -- Always test AI-generated code before committing
