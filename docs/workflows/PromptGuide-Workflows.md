# Workflow Prompt Guide

> Prompts for using AI to generate, analyze, and improve workflow documentation
> from feature descriptions, tickets, and business requirements.

---

## 1. Generate Workflow from Feature Description

Use when you have a feature idea and need to map out the full process.

```
I need to document the workflow for the following feature:

Feature: [Feature name]
Description: [What the feature does]
User types involved: [List user roles]
External services: [APIs, payment providers, email, etc.]

Please generate a complete workflow document that includes:
1. Overview (1-2 sentences)
2. Trigger (what starts this workflow)
3. Actors (users, system, external services)
4. Prerequisites (what must be true before starting)
5. Mermaid flow diagram covering all paths
6. Detailed steps with actor, action, input, output, and error handling
7. Decision points table
8. Error scenarios table
9. Notification triggers (email, SMS, push, in-app)
10. Success metrics (measurable KPIs)

Use this format for the Mermaid diagram:
- [Rectangle] for process steps
- {Diamond} for decisions
- ([Stadium]) for start/end
- [(Database)] for data operations

Make the diagram readable -- no more than 15-20 nodes.
Include both happy path and key error paths.
```

---

## 2. Convert User Story to Workflow

Use when you have user stories and need to create a technical workflow.

```
Convert these user stories into a detailed workflow document:

User Stories:
- As a [role], I want to [action] so that [benefit]
- As a [role], I want to [action] so that [benefit]
- As a [role], I want to [action] so that [benefit]

Acceptance Criteria:
- [Criterion 1]
- [Criterion 2]
- [Criterion 3]

Tech stack context: [your stack]
Database: [your database]
Auth system: [your auth system]

Please produce:
1. A Mermaid flow diagram showing all user stories as a connected workflow
2. Step-by-step documentation for each path
3. API endpoints needed for each step
4. Database operations at each step
5. Edge cases and error scenarios
6. Estimated implementation complexity for each step
```

---

## 3. Generate Mermaid Diagram from Process Description

Use when you need a quick visual diagram.

```
Create a Mermaid flowchart for this process:

Process: [Name]
Steps:
1. [Step 1]
2. [Step 2 - with a decision point: if X then Y, else Z]
3. [Step 3]
4. [Step 4]
...

Requirements:
- Use flowchart TD (top-down) layout
- Include decision diamonds for all branching points
- Show error paths in addition to the happy path
- Use descriptive node labels (not just "Step 1")
- Keep it to a single readable diagram (max 20 nodes)
- Add styling for success (green), error (red), and decision (blue) nodes
```

---

## 4. Audit Workflow for Missing Edge Cases

Use to review an existing workflow for gaps.

```
Review this workflow for missing edge cases and failure modes:

[Paste your workflow document or Mermaid diagram]

Check for:
1. Missing error handling (what if any step fails?)
2. Race conditions (what if two actions happen simultaneously?)
3. Timeout scenarios (what if an external service is slow?)
4. Permission edge cases (what if user roles change mid-flow?)
5. Data validation gaps (what if input is malformed?)
6. Concurrency issues (what if two users trigger this at once?)
7. Rollback scenarios (what if we need to undo a partial flow?)
8. Retry logic (should failed steps be retried automatically?)
9. Idempotency (can this be safely re-run if a step is repeated?)
10. Observability gaps (can we trace what happened if something goes wrong?)

For each issue found, suggest:
- The specific scenario
- Its likelihood and impact
- A recommended solution
```

---

## 5. Generate Email Sequence for Workflow

Use when a workflow includes user communication touchpoints.

```
Generate an email sequence for this workflow:

Workflow: [Name]
Context: [Brief description of the workflow]
User type: [Who receives the emails]

Touchpoints needed:
1. [Trigger event 1] -- [purpose of email]
2. [Trigger event 2] -- [purpose of email]
3. [Trigger event 3] -- [purpose of email]

For each email, provide:
- Subject line (under 50 characters)
- Preview text (under 90 characters)
- Email body outline (sections and key content)
- CTA button text and destination
- Timing (when to send relative to trigger)
- Fallback if user doesn't engage

Use a friendly but professional tone.
Emails should be mobile-friendly (single column, large CTA buttons).
```

---

## 6. Generate Test Scenarios from Workflow

Use to create comprehensive test coverage for a workflow.

```
Generate test scenarios for this workflow:

[Paste workflow document or Mermaid diagram]

Generate tests covering:
1. Happy path (end-to-end success)
2. Each decision branch (both sides of every diamond)
3. Each error scenario
4. Boundary conditions (empty data, max values, special characters)
5. Permission variations (different user roles)
6. Concurrent execution (two users at same time)
7. Timeout and retry scenarios
8. State transitions (valid and invalid)

For each test, provide:
- Test name (descriptive)
- Preconditions
- Steps
- Expected result
- Priority (Critical / High / Medium / Low)

Format as a test matrix I can import into my test plan.
```

---

## 7. Convert Workflow to API Specification

Use when you need to implement the backend for a documented workflow.

```
Convert this workflow into API endpoint specifications:

[Paste workflow document]

For each API endpoint needed:
1. Method and path (RESTful naming)
2. Authentication requirements
3. Request body/params with types
4. Response body with types
5. Error responses with status codes
6. Rate limiting recommendations
7. Webhook events to emit

Also provide:
- Database schema changes needed
- Background job definitions
- Third-party API integrations required

Use TypeScript types for request/response definitions.
Follow REST conventions for resource naming.
```

---

## 8. Optimize Workflow for Performance

Use when a workflow feels slow or has performance concerns.

```
Analyze this workflow for performance optimization opportunities:

[Paste workflow document or Mermaid diagram]

Current performance:
- Average completion time: [time]
- Bottleneck: [known bottleneck if any]
- Volume: [requests per minute/hour]

Analyze:
1. Which steps can run in parallel?
2. Where can we use async processing (background jobs)?
3. What data can be cached to avoid redundant fetches?
4. Are there unnecessary synchronous external API calls?
5. Can any steps be combined or eliminated?
6. Where should we add database indexes?
7. Are there N+1 query patterns hidden in the flow?

Provide a revised Mermaid diagram showing the optimized flow,
with annotations on expected performance improvements.
```

---

## Tips for Workflow Prompts

1. **Include context** -- always describe your tech stack and constraints
2. **Be specific about actors** -- name the user roles and systems involved
3. **Ask for diagrams** -- Mermaid diagrams are worth a thousand words
4. **Request error paths** -- happy paths are easy, error handling is where bugs live
5. **Include notification needs** -- workflows often have communication touchpoints
6. **Ask for metrics** -- define how you'll know the workflow is working well
7. **Iterate** -- start with a rough flow, then ask the AI to find gaps
