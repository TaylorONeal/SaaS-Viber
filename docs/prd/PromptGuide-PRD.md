# PRD Prompt Guide

> **Purpose**: Ready-to-use prompts for AI-assisted PRD writing. Each prompt is designed to produce structured, high-quality output that aligns with the [PRD-TEMPLATE.md](./PRD-TEMPLATE.md) format. Copy a prompt, fill in the placeholders (marked with `{{double braces}}`), and submit to your AI assistant.
>
> **Last Updated**: [Date]

---

## How to Use These Prompts

1. **Choose the prompt** that matches what you need.
2. **Fill in the placeholders** (`{{like this}}`) with your specific context.
3. **Submit to your AI assistant** (Claude, GPT, etc.).
4. **Review and refine** the output. AI-generated PRD content is a starting point, not a finished product.
5. **Paste into the PRD template** at the appropriate section.

**Tips for better results**:
- The more specific your placeholder content, the better the output.
- Include constraints ("we use PostgreSQL", "must work on mobile") for grounded technical output.
- Run multiple prompts in sequence to build a complete PRD.
- Always have a human review AI-generated acceptance criteria and edge cases -- these are the most likely to have subtle gaps.

---

## Prompt 1: Generate a PRD from a Feature Idea

Use this when you have a feature idea and want a complete first-draft PRD.

```
I need you to write a Product Requirements Document for a SaaS feature.

FEATURE IDEA:
{{Describe the feature in 2-5 sentences. What does it do? Who is it for? Why does it matter?}}

PRODUCT CONTEXT:
- Product type: {{e.g., project management tool, CRM, analytics platform}}
- Target users: {{e.g., small business owners, enterprise IT admins, freelance designers}}
- Tech stack: {{e.g., React frontend, Node.js API, PostgreSQL database}}
- Current stage: {{e.g., MVP, growth stage, mature product}}

CONSTRAINTS:
{{List any known constraints: timeline, budget, regulatory, technical debt, etc.}}

Please generate a complete PRD following this structure:

1. **Problem Statement** -- 2-3 sentences describing the user pain point. Include an
   impact assessment (users affected, frequency, severity, current workaround).

2. **Goals & Success Metrics** -- 2-3 goals with checkboxes. A metrics table with
   columns: Metric | Current Baseline | Target | Timeframe | Measurement Method.
   Include 1-2 anti-goals.

3. **User Stories** -- Organized by user role. Each story follows "As a [role], I want
   to [action] so that [benefit]". Include a priority matrix table with columns:
   Story ID | User Story (short) | Priority (P0/P1/P2) | Effort (S/M/L/XL) | Phase.

4. **Scope** -- In Scope (what we are building), Out of Scope (what we are explicitly
   not building and why), Future Considerations (what we might build later).

5. **Detailed Requirements** -- 2-4 requirement areas, each with: Description,
   Acceptance Criteria (specific, testable checkboxes), UI/UX Notes, Data Model
   (tables/fields), API (endpoints with method, path, description).

6. **Technical Design** -- Database changes table, API changes table, Frontend
   components table, Third-party integrations table, Caching strategy.

7. **Edge Cases & Error Handling** -- Table with columns: # | Scenario | Likelihood |
   Impact | Expected Behavior | Test Coverage. At least 8 edge cases.

8. **Security Considerations** -- Checklist of security requirements.

9. **Performance Requirements** -- Table with latency, throughput, and concurrency targets.

10. **Rollout Plan** -- Pre-launch checklist, phased rollout (internal > beta >
    gradual > GA), post-launch monitoring plan.

11. **Dependencies** -- Upstream and downstream dependencies with risk assessment.

12. **Open Questions** -- 3-5 questions that need resolution before or during development.

Be specific and opinionated in your recommendations. Do not use vague language like
"as needed" or "if applicable." Every acceptance criterion should be testable.
Reference the tech stack I provided in technical sections.
```

---

## Prompt 2: Expand User Stories from a Brief Description

Use this when you have a rough idea of what a feature should do and need thorough user stories.

```
I need comprehensive user stories for a SaaS feature. Expand my brief description
into detailed, well-structured user stories.

FEATURE BRIEF:
{{1-3 sentences describing the feature at a high level}}

USER ROLES IN MY PRODUCT:
{{List the roles, e.g.:
- End User: regular user of the product
- Admin: manages organization settings and users
- Billing Admin: manages subscription and payments
- Guest: limited-access invited user}}

CONTEXT:
{{Any additional context: what problem this solves, what exists today, etc.}}

For each user role, generate:

1. **Primary Stories** (P0): Stories that represent the core functionality this
   role needs. These must ship in v1. Format: "As a [role], I want to [specific
   action] so that [specific measurable benefit]."

2. **Supporting Stories** (P1): Stories that enhance the core experience. Important
   but can ship in v1.1. Same format.

3. **Nice-to-Have Stories** (P2): Stories that would delight users but are not
   critical. Can be deferred. Same format.

4. **System Stories**: Stories from the system's perspective for background
   processes, data integrity, and operations. Format: "As the system, I need to
   [action] so that [benefit]."

After the stories, generate a **Priority Matrix** table with columns:
Story ID | User Story (short) | Role | Priority | Effort (S/M/L/XL) | Dependencies | Phase

Guidelines:
- Each story should describe ONE capability (not multiple combined)
- The "so that" clause must be a real user benefit, not a restatement of the action
- Include at least one story per role related to error handling or edge cases
- Include at least one story about what happens when the feature is NOT available
  (degraded state, feature flag off, etc.)
- Total: aim for 15-25 stories across all roles
```

---

## Prompt 3: Generate Edge Cases for a Feature

Use this when you have a feature design and need to identify what could go wrong.

```
I need a comprehensive edge case analysis for a SaaS feature. Identify scenarios
that could cause unexpected behavior, data issues, security problems, or poor
user experience.

FEATURE DESCRIPTION:
{{Describe the feature: what it does, the data it touches, the user interactions
involved, any external services it depends on}}

TECHNICAL DETAILS:
- Database: {{e.g., PostgreSQL with these relevant tables: users, projects, ...}}
- API endpoints involved: {{e.g., POST /api/projects, PATCH /api/projects/:id}}
- External services: {{e.g., Stripe for payments, SendGrid for email}}
- Authentication: {{e.g., JWT-based, session-based}}
- Multi-tenancy: {{Yes/No, how is it implemented}}

Generate edge cases organized into these categories:

1. **Input & Validation Edge Cases**
   - Malformed input, boundary values, Unicode, injection attempts

2. **Authentication & Authorization Edge Cases**
   - Session expiry, role changes, cross-tenant access, API key scenarios

3. **Concurrency & Race Conditions**
   - Simultaneous edits, double submissions, stale data

4. **Data Integrity Edge Cases**
   - Orphaned records, cascading effects, migration issues

5. **External Service Failures**
   - Timeout, unavailability, rate limiting, webhook delivery failures

6. **Performance & Scale Edge Cases**
   - Large datasets, slow queries, memory issues

7. **User Experience Edge Cases**
   - Network interruption, browser back button, multiple tabs,
     mobile-specific issues

8. **Business Logic Edge Cases**
   - Billing implications, plan limit boundaries, timezone issues

For each edge case, provide:
| # | Scenario | Trigger | Impact (Critical/High/Medium/Low) | Likelihood (High/Medium/Low) | Recommended Mitigation | Test Type (Unit/Integration/E2E/Manual) |

Prioritize the most dangerous (high impact + high likelihood) scenarios first
within each category. Aim for at least 5 edge cases per category (40+ total).
```

---

## Prompt 4: Create Acceptance Criteria from Requirements

Use this when you have a requirements description and need precise, testable acceptance criteria.

```
I need detailed acceptance criteria for a set of feature requirements. Each
criterion must be specific, testable, and unambiguous -- something a QA engineer
could verify without asking clarifying questions.

REQUIREMENTS:
{{Paste the requirement description. Example:
"Users should be able to invite team members to their organization via email.
Invited users receive an email with a link to join. Admins can see pending
invitations and revoke them."}}

TECHNICAL CONTEXT:
- Frontend: {{e.g., React with TypeScript}}
- API style: {{e.g., REST, GraphQL}}
- Auth model: {{e.g., JWT with role-based access control}}
- Relevant roles: {{e.g., Admin, Member, Guest}}

For each requirement, generate acceptance criteria in this format:

### [Requirement Name]

**Happy Path Criteria**:
- [ ] [Criterion -- describes the expected behavior when everything goes right]
- [ ] [Criterion]
- [ ] [Criterion]

**Validation & Error Criteria**:
- [ ] [Criterion -- describes behavior for invalid inputs, missing data, etc.]
- [ ] [Criterion]

**Authorization Criteria**:
- [ ] [Criterion -- describes who can and who cannot perform this action]
- [ ] [Criterion]

**Edge Case Criteria**:
- [ ] [Criterion -- describes behavior in unusual but possible scenarios]
- [ ] [Criterion]

**UI/UX Criteria**:
- [ ] [Criterion -- describes visual states: loading, empty, error, success]
- [ ] [Criterion -- responsive behavior, accessibility]

**Performance Criteria**:
- [ ] [Criterion -- latency, payload size, or throughput expectation]

Guidelines:
- Each criterion should test ONE thing
- Use concrete values, not vague terms (say "within 200ms" not "quickly")
- Include the expected HTTP status codes for API-level criteria
- Cover both the positive case AND the negative case for each validation
- Total: aim for 8-15 criteria per requirement area
```

---

## Prompt 5: Generate a Technical Design from a PRD

Use this when you have a completed PRD and need to flesh out the technical implementation plan.

```
I need a technical design document based on the following PRD content. The design
should be specific enough for a senior engineer to begin implementation.

PRD CONTENT:
{{Paste the relevant sections of your PRD -- at minimum: Problem Statement,
Detailed Requirements (Section 5), and any existing Technical Design notes}}

SYSTEM CONTEXT:
- Architecture: {{e.g., monolith, microservices, serverless}}
- Language/Framework: {{e.g., TypeScript / Next.js / Express}}
- Database: {{e.g., PostgreSQL 15, managed on AWS RDS}}
- ORM: {{e.g., Prisma, Drizzle, Sequelize, raw SQL}}
- Cache: {{e.g., Redis 7, used for sessions and rate limiting}}
- Queue: {{e.g., BullMQ on Redis, SQS}}
- Auth: {{e.g., NextAuth, custom JWT, Clerk}}
- File storage: {{e.g., S3, Cloudflare R2}}
- Current relevant schema: {{Paste relevant table definitions or model files}}

Generate the following:

1. **Database Schema Changes**
   - For each new or modified table: full CREATE TABLE statement (or Prisma model)
   - Include all constraints, indexes, and foreign keys
   - Note migration strategy (additive only? backfill needed?)
   - Explain indexing decisions

2. **API Endpoint Design**
   - For each endpoint: method, path, description, auth requirement, rate limit
   - Request schema (with types and validation rules)
   - Response schema (with types)
   - Error response catalog (status code, error code, message)
   - Example request/response pair

3. **Frontend Component Architecture**
   - Component tree diagram (which components compose the feature)
   - State management approach (local state, context, global store)
   - Key props and interfaces for each component
   - Data fetching strategy (SWR, React Query, server components, etc.)

4. **Background Jobs / Workers**
   - Job name, trigger, payload, retry strategy, timeout
   - Idempotency approach

5. **Caching Strategy**
   - What to cache, cache key format, TTL, invalidation strategy

6. **Security Implementation**
   - Input validation approach
   - Authorization check placement
   - Data sanitization
   - Audit logging

7. **Testing Strategy**
   - Unit test targets (which functions/modules)
   - Integration test targets (which API endpoints)
   - E2E test scenarios (which user flows)
   - Test data seeding approach

8. **Observability**
   - Key metrics to instrument
   - Log points (what to log and at what level)
   - Alert thresholds

Be very specific. Use actual code-level names, not abstract placeholders.
If you need to make assumptions, state them explicitly.
```

---

## Prompt 6: Audit Implementation Against a PRD

Use this when you have both a PRD and an existing implementation and need to find gaps.

```
I need you to perform a systematic audit comparing a PRD specification against
the actual implementation. Identify every gap, drift, and missing piece.

PRD SPECIFICATION:
{{Paste the full PRD or the relevant sections (especially Sections 5-9:
Detailed Requirements, Technical Design, Edge Cases, Security, Performance)}}

IMPLEMENTATION:
{{Paste the relevant implementation code, schema, or describe what exists.
Include:
- Database schema (tables, columns, constraints)
- API routes/controllers
- Frontend components (list them)
- Test files (list them)
- Any configuration (feature flags, environment variables)}}

Perform the audit across these dimensions:

1. **Schema Audit**
   - Compare PRD data model to actual database schema
   - Flag: missing tables, missing columns, wrong types, missing constraints,
     missing indexes, extra columns not in PRD

2. **API Audit**
   - Compare PRD API spec to actual endpoints
   - Flag: missing endpoints, wrong methods, missing request validation,
     wrong response shapes, missing error handling, missing rate limiting

3. **UI Audit**
   - Compare PRD UI/UX requirements to actual components
   - Flag: missing screens, missing states (empty/loading/error), missing
     responsive behavior, missing accessibility features

4. **Business Logic Audit**
   - Compare PRD acceptance criteria to implementation
   - For each criterion: mark as Implemented / Partially Implemented / Missing
   - Note any implemented behavior that contradicts the PRD

5. **Edge Case Audit**
   - For each edge case in PRD Section 7: is it handled in code?
   - Flag unhandled edge cases with severity

6. **Security Audit**
   - For each security requirement in PRD Section 8: is it implemented?
   - Flag: missing auth checks, missing input validation, missing audit logging

7. **Test Coverage Audit**
   - For each requirement area: do tests exist?
   - Flag: untested acceptance criteria, untested edge cases, missing
     integration tests for API endpoints

Output format:

### Audit Summary
| Dimension | Items Checked | Passing | Gaps | Critical Gaps |
|-----------|--------------|---------|------|---------------|

### Detailed Findings
For each gap:
| # | Dimension | PRD Reference | Expected | Actual | Severity | Recommended Fix |

### Priority Recommendations
Top 5 gaps to close, ordered by severity and effort.
```

---

## Prompt 7: Generate a Competitive Analysis for a Feature

Use this when you need to understand how competitors handle a specific feature to inform your PRD.

```
I need a competitive analysis for a specific feature area to inform our product
requirements. Analyze how existing products handle this and identify opportunities
for differentiation.

FEATURE AREA:
{{Describe the feature area, e.g., "user onboarding flow", "team permission
management", "billing and subscription management", "notification system"}}

OUR PRODUCT:
- Type: {{e.g., project management SaaS for small teams}}
- Target market: {{e.g., SMBs with 5-50 employees}}
- Current state: {{What we have today for this feature, if anything}}

COMPETITORS TO ANALYZE:
{{List 3-6 competitors. Example:
1. Competitor A (direct competitor, similar market)
2. Competitor B (upmarket competitor, enterprise)
3. Competitor C (adjacent product with strong implementation of this feature)
4. Competitor D (innovative newcomer)}}

For each competitor, analyze:

1. **Feature Implementation**
   - How do they implement this feature?
   - What is the user flow (step by step)?
   - What customization/configuration options exist?
   - What are the limits/restrictions?

2. **Strengths**
   - What do they do really well?
   - What do users praise in reviews?

3. **Weaknesses**
   - What are the common complaints?
   - What gaps or limitations exist?
   - What feels clunky or confusing?

4. **Pricing Impact**
   - Is this feature gated by plan tier?
   - How does it affect their pricing model?

Then synthesize:

5. **Feature Comparison Matrix**
   | Capability | Us (current) | Competitor A | Competitor B | Competitor C |
   |-----------|-------------|-------------|-------------|-------------|

6. **Table Stakes** (must-have to be competitive)
   - Features every competitor has that we must also have

7. **Differentiators** (opportunities to stand out)
   - Gaps in the market where no competitor excels
   - Innovative approaches we could take
   - Underserved user needs

8. **Recommendations for Our PRD**
   - What to include in v1 (parity)
   - What to include in v2 (differentiation)
   - What to explicitly exclude and why

Be specific. Reference actual UI patterns, user flows, and feature details rather
than vague statements like "good UX." If you are unsure about a competitor's
specific implementation, say so rather than guessing.
```

---

## Bonus: Prompt Chaining Strategy

For a complete PRD from scratch, run these prompts in sequence:

```
Step 1: Prompt 7 (Competitive Analysis)     -- Understand the landscape
Step 2: Prompt 1 (Generate PRD)              -- Draft the full PRD
Step 3: Prompt 2 (Expand User Stories)       -- Deepen the user stories
Step 4: Prompt 4 (Acceptance Criteria)       -- Make requirements testable
Step 5: Prompt 3 (Edge Cases)                -- Identify what could go wrong
Step 6: Prompt 5 (Technical Design)          -- Flesh out the implementation plan
Step 7: [After building] Prompt 6 (Audit)    -- Verify implementation matches PRD
```

Each prompt builds on the output of the previous one. Paste relevant output from
the prior step into the context of the next prompt.

---

## Appendix

### Related Documents
- [PRD-TEMPLATE.md](./PRD-TEMPLATE.md) -- The template these prompts generate content for
- [PRD-001-example.md](./PRD-001-example.md) -- Example of a completed PRD
- [EDGE_CASES.md](./EDGE_CASES.md) -- Pre-populated edge cases to supplement Prompt 3
- [ATTRIBUTION_TRACKING.md](./ATTRIBUTION_TRACKING.md) -- Analytics taxonomy for metrics prompts
- [PRD-IMPLEMENTATION-AUDIT.md](./PRD-IMPLEMENTATION-AUDIT.md) -- Audit framework for Prompt 6

### Changelog
| Date | Author | Change |
|------|--------|--------|
| [Date] | [Name] | [Initial creation / update description] |
