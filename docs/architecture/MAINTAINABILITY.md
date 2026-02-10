# Maintainability — [YOUR_APP_NAME]

> **Purpose:** Define code organization standards, style guidelines, testing strategy,
> dependency management, code review processes, and documentation standards to keep the
> codebase healthy as it grows.
>
> **Last Updated:** [DATE]
> **Status:** [Template / In Progress / Complete]

---

## Code Organization Standards

### Project Structure

```
[YOUR_PROJECT_ROOT]/
├── src/
│   ├── app/                    # App router / pages (Next.js) or routes
│   │   ├── (auth)/             # Auth-required route group
│   │   ├── (public)/           # Public route group
│   │   └── api/                # API routes
│   ├── components/             # Shared UI components
│   │   ├── ui/                 # Primitive components (Button, Input, Modal)
│   │   ├── layout/             # Layout components (Header, Sidebar, Footer)
│   │   └── [feature]/          # Feature-specific components
│   ├── hooks/                  # Custom React hooks
│   ├── services/               # API service layer (fetch wrappers)
│   ├── lib/                    # Utility functions and helpers
│   ├── types/                  # TypeScript type definitions
│   ├── stores/                 # State management (if using Zustand, Redux, etc.)
│   ├── providers/              # React context providers
│   ├── styles/                 # Global styles, theme configuration
│   └── constants/              # Application constants and enums
├── tests/
│   ├── unit/                   # Unit tests (mirror src/ structure)
│   ├── integration/            # Integration tests
│   └── e2e/                    # End-to-end tests
├── public/                     # Static assets
├── docs/                       # Documentation (you are here)
├── scripts/                    # Build and utility scripts
└── [config files]              # tsconfig, eslint, prettier, etc.
```

### Naming Conventions

| Item | Convention | Example |
|---|---|---|
| Files (components) | PascalCase | `UserProfile.tsx` |
| Files (utilities) | camelCase | `formatDate.ts` |
| Files (hooks) | camelCase, `use` prefix | `useAuth.ts` |
| Files (types) | camelCase or PascalCase | `user.types.ts` or `User.ts` |
| Files (tests) | Same as source + `.test` | `UserProfile.test.tsx` |
| Directories | kebab-case or camelCase | `user-profile/` or `userProfile/` |
| Components | PascalCase | `<UserProfile />` |
| Functions | camelCase | `formatCurrency()` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| Types/Interfaces | PascalCase | `interface UserProfile {}` |
| Enums | PascalCase (enum), UPPER_SNAKE (values) | `enum Status { ACTIVE, INACTIVE }` |
| Database tables | snake_case, plural | `user_profiles` |
| Database columns | snake_case | `created_at` |
| API endpoints | kebab-case | `/api/user-profiles` |
| Environment variables | UPPER_SNAKE_CASE | `DATABASE_URL` |

### File Organization Rules

1. **One component per file.** A component file exports one default component.
2. **Co-locate related files.** Tests, styles, and types near the component.
3. **Index files for public API.** Each directory can have an `index.ts` that re-exports its public interface.
4. **No circular dependencies.** Use a dependency analysis tool to enforce.
5. **Maximum file length: [X] lines.** If a file exceeds this, refactor into smaller modules.

---

## TypeScript & Style Guidelines

### TypeScript Configuration

```jsonc
// Key tsconfig.json settings
{
  "compilerOptions": {
    "strict": true,                    // Enable all strict checks
    "noUncheckedIndexedAccess": true,  // Array/object access can be undefined
    "noImplicitReturns": true,         // All code paths must return
    "noFallthroughCasesInSwitch": true,// Switch cases must break or return
    "forceConsistentCasingInFileNames": true,
    "noUnusedLocals": true,            // Flag unused variables
    "noUnusedParameters": true         // Flag unused parameters
  }
}
```

### ESLint Rules (Key Decisions)

| Rule | Setting | Rationale |
|---|---|---|
| `no-any` | Error | Force explicit types |
| `no-explicit-any` | Warn → Error over time | Migrate gradually |
| `prefer-const` | Error | Immutability by default |
| `no-console` | Warn (Error in production) | Use proper logging |
| `react-hooks/exhaustive-deps` | Error | Prevent stale closures |
| `import/order` | Warn | Consistent import ordering |
| `no-unused-vars` | Error | Keep code clean |
| `consistent-return` | Error | Predictable function behavior |

### Code Style Principles

1. **Prefer composition over inheritance.** Use hooks and higher-order components.
2. **Prefer immutability.** Use `const`, spread operators, and `.map()` over mutation.
3. **Prefer explicit over implicit.** Name things clearly; avoid abbreviations.
4. **Prefer small functions.** A function should do one thing. If it needs a comment to explain what it does, it is too complex.
5. **Prefer early returns.** Reduce nesting with guard clauses.
6. **Avoid magic numbers.** Extract to named constants.
7. **Handle errors explicitly.** Never silently catch and ignore errors.

---

## Testing Strategy

### Testing Pyramid

```
          ╱  ╲
         ╱ E2E╲           Few: Critical user journeys
        ╱──────╲           (Playwright, Cypress)
       ╱Integra-╲
      ╱  tion    ╲        Some: API endpoints, DB queries
     ╱────────────╲        (Supertest, Testing Library)
    ╱    Unit      ╲
   ╱    Tests       ╲     Many: Functions, components, hooks
  ╱──────────────────╲     (Vitest, Jest, React Testing Library)
```

### Coverage Targets

| Layer | Target Coverage | Enforcement |
|---|---|---|
| Unit Tests | [X]% line coverage | CI gate |
| Integration Tests | All API endpoints | CI gate |
| E2E Tests | All critical user flows | CI gate (or nightly) |

### What to Test

| Category | Test Type | Examples |
|---|---|---|
| Utility functions | Unit | `formatDate()`, `calculateTotal()`, `validateEmail()` |
| React hooks | Unit | `useAuth()`, `usePermission()`, `usePagination()` |
| Components (logic) | Unit | Conditional rendering, event handlers, form validation |
| Components (UI) | Snapshot / Visual | Layout, styling, responsive behavior |
| API endpoints | Integration | Request/response, auth, error handling |
| Database operations | Integration | CRUD, constraints, migrations |
| User flows | E2E | Signup, login, core workflow, checkout |

### What NOT to Test

- Third-party library internals (trust the library's own tests)
- Simple pass-through components (wrappers with no logic)
- CSS styling (unless using visual regression testing)
- Implementation details (test behavior, not how it works)

### Testing Patterns

```typescript
// Pattern: Arrange-Act-Assert
describe('calculateDiscount', () => {
  it('applies percentage discount to total', () => {
    // Arrange
    const total = 100;
    const discountPercent = 20;

    // Act
    const result = calculateDiscount(total, discountPercent);

    // Assert
    expect(result).toBe(80);
  });
});

// Pattern: Test behavior, not implementation
describe('LoginForm', () => {
  it('shows error message on invalid credentials', async () => {
    render(<LoginForm />);

    await userEvent.type(screen.getByLabelText('Email'), 'test@example.com');
    await userEvent.type(screen.getByLabelText('Password'), 'wrong');
    await userEvent.click(screen.getByRole('button', { name: 'Log in' }));

    expect(screen.getByText('Invalid credentials')).toBeInTheDocument();
  });
});
```

---

## Dependency Management Policy

### Adding Dependencies

Before adding a new dependency, evaluate:

| Criterion | Question | Threshold |
|---|---|---|
| Necessity | Can this be done in < 50 lines of custom code? | If yes, write it yourself |
| Maintenance | Is the package actively maintained? (last commit < 6 months) | Must be active |
| Size | What does it add to the bundle? | < [X] KB gzipped |
| Security | Any known vulnerabilities? | Zero critical/high |
| License | Is the license compatible? (MIT, Apache 2.0, BSD) | Must be compatible |
| Alternatives | Are there lighter/better maintained alternatives? | Compare top 3 |

### Dependency Update Schedule

| Frequency | Action | Tool |
|---|---|---|
| Daily | Automated vulnerability scanning | `npm audit` / Dependabot |
| Weekly | Review and merge automated PRs for patch updates | Dependabot / Renovate |
| Monthly | Review minor version updates | Manual review |
| Quarterly | Review major version updates | Manual review + testing |

### Lockfile Policy

- **Always commit the lockfile** (`package-lock.json` or `pnpm-lock.yaml`)
- **Never manually edit the lockfile**
- **Use exact versions** in production dependencies (no `^` or `~`)
- **Use `npm ci`** (or equivalent) in CI, not `npm install`

---

## Code Review Guidelines

### Review Checklist

Every pull request reviewer should check:

- [ ] **Correctness:** Does the code do what it claims to do?
- [ ] **Tests:** Are there tests? Do they test the right things?
- [ ] **Types:** Are TypeScript types specific and correct (no `any`)?
- [ ] **Error handling:** Are errors caught and handled properly?
- [ ] **Security:** Any injection risks, exposed secrets, missing auth checks?
- [ ] **Performance:** Any N+1 queries, unnecessary re-renders, large payloads?
- [ ] **Naming:** Are variables, functions, and files named clearly?
- [ ] **Duplication:** Is there duplicated logic that should be extracted?
- [ ] **Accessibility:** Are ARIA attributes, keyboard navigation correct?
- [ ] **Documentation:** Are complex decisions documented in comments or ADRs?

### Pull Request Template

```markdown
## What
[One sentence: what does this PR do?]

## Why
[One sentence: why is this change needed?]

## How
[Brief description of the approach taken]

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed
- [ ] [Describe what was tested manually]

## Screenshots
[If UI changes, include before/after screenshots]

## Checklist
- [ ] Types are correct (no `any`)
- [ ] Error handling is in place
- [ ] Accessibility verified
- [ ] No console.log left in code
- [ ] Documentation updated if needed
```

### Review Turnaround

| PR Size | Target Review Time |
|---|---|
| Small (< 100 lines) | < 4 hours |
| Medium (100-500 lines) | < 8 hours |
| Large (> 500 lines) | < 24 hours (consider breaking up) |

---

## Documentation Standards

### Code Documentation

| What to Document | How |
|---|---|
| Complex business logic | Inline comments explaining WHY, not WHAT |
| Public APIs / exported functions | JSDoc with `@param`, `@returns`, `@example` |
| Non-obvious design decisions | Comment linking to ADR or explaining rationale |
| Workarounds and hacks | `// HACK:` or `// WORKAROUND:` with explanation and issue link |
| TODOs | `// TODO(username):` with description and issue link |

### Architecture Documentation

| Document | Update Frequency | Owner |
|---|---|---|
| Domain Model | When entities change | [Role] |
| ADRs (Architecture Decision Records) | When significant decisions are made | [Role] |
| API Documentation | When endpoints change | [Role] |
| Runbooks | When operational procedures change | [Role] |
| This document (Maintainability) | Quarterly review | [Role] |

---

## Implementation Checklist

- [ ] Project structure follows the documented pattern
- [ ] TypeScript strict mode enabled
- [ ] ESLint and Prettier configured and enforced in CI
- [ ] Testing strategy defined with coverage targets
- [ ] Dependency management policy communicated to team
- [ ] PR template configured in repository
- [ ] Code review turnaround expectations set
- [ ] Documentation standards communicated

---

## Prompt Guide Reference

See [PromptGuide-Architecture.md](./PromptGuide-Architecture.md) for prompts to review code quality and generate test suites.

---

*Status: Template*
*Next review: [DATE]*
