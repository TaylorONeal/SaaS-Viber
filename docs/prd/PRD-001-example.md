# PRD-001: User Onboarding Flow

> **THIS IS AN EXAMPLE PRD.** It demonstrates how to use the [PRD-TEMPLATE.md](./PRD-TEMPLATE.md) to write a thorough product requirements document. Replace all content with your own when creating a real PRD.

> **Status**: Approved
> **Author**: Jane Chen, Product Lead
> **Created**: 2025-03-15
> **Last Updated**: 2025-04-02
> **Phase**: Phase 1 -- Foundation

---

## 1. Problem Statement

New users who sign up for the platform abandon the product within the first 24 hours at a rate of 68%. Post-signup surveys and session recordings reveal that users struggle to understand the core value of the product and do not know where to start. Support tickets tagged "getting started" account for 34% of all inbound volume in Q1.

**Impact Assessment**:
- **Users Affected**: 100% of new sign-ups (approximately 2,400/month)
- **Frequency**: Every new user encounters this on first session
- **Severity**: Critical
- **Current Workaround**: Users either figure it out on their own (32%), contact support (12%), or abandon (56%). A static "Getting Started" help article exists but has a 9% click-through rate and 22% completion rate.

## 2. Goals & Success Metrics

### Goals
- [x] Reduce first-24-hour abandonment from 68% to under 40%
- [x] Increase "activation" (user completes one core action) from 18% to 50% within the first session
- [ ] Decrease "getting started" support tickets by 50%

### Success Metrics
| Metric | Current Baseline | Target | Timeframe | Measurement Method |
|--------|-----------------|--------|-----------|-------------------|
| 24-hour retention | 32% | 60% | 30 days post-launch | Mixpanel cohort analysis |
| Activation rate (first session) | 18% | 50% | 30 days post-launch | Custom event: `core_action_completed` within session |
| Time to first core action | 14 minutes | 4 minutes | 30 days post-launch | Mixpanel funnel timing |
| Getting started support tickets | 408/month | 200/month | 60 days post-launch | Zendesk tag filter |
| Onboarding completion rate | N/A (new) | 70% | 30 days post-launch | Custom event: `onboarding_completed` |
| 7-day retention | 21% | 40% | 60 days post-launch | Mixpanel cohort analysis |

### Anti-Goals
- We are NOT trying to showcase every feature in the product during onboarding. Breadth kills activation.
- We are NOT trying to collect extensive profile data during sign-up. Every field reduces conversion.
- We are NOT building a generic product tour that highlights UI elements. We are building a guided experience that delivers value.

## 3. User Stories

### New User (Free Tier)
- As a new user, I want to understand what the product does for me within 60 seconds of signing up so that I can decide whether to invest my time.
- As a new user, I want to be guided through creating my first [core object] so that I experience the product's value immediately.
- As a new user, I want to see a progress indicator so that I know how much of the setup remains and feel motivated to complete it.
- As a new user, I want to be able to skip the onboarding and explore on my own so that I do not feel trapped in a linear flow.
- As a new user, I want to resume onboarding where I left off if I leave and come back so that I do not have to start over.

### New User (Invited to Team)
- As an invited user, I want the onboarding to acknowledge that I am joining an existing team so that the experience feels contextual rather than generic.
- As an invited user, I want to see content my team has already created so that I understand how the product is being used in my organization.

### Admin (Account Owner)
- As an admin, I want to see which invited team members have completed onboarding so that I can follow up with those who have not.
- As an admin, I want to customize the welcome message new team members see so that onboarding feels branded to my organization.

### System
- As the system, I need to track onboarding step completion events so that we can analyze funnel drop-off and iterate on the flow.
- As the system, I need to trigger a re-engagement email if onboarding is not completed within 24 hours so that we recover abandoned users.

**Priority Matrix**:
| Story ID | User Story (short) | Priority | Effort | Phase |
|----------|-------------------|----------|--------|-------|
| US-1 | Understand value in 60 seconds | P0 | M | 1 |
| US-2 | Guided first core action | P0 | L | 1 |
| US-3 | Progress indicator | P0 | S | 1 |
| US-4 | Skip / explore on own | P0 | S | 1 |
| US-5 | Resume where left off | P1 | M | 1 |
| US-6 | Team-aware onboarding | P1 | M | 2 |
| US-7 | See existing team content | P2 | M | 2 |
| US-8 | Admin sees team completion | P1 | S | 2 |
| US-9 | Custom welcome message | P2 | S | 3 |
| US-10 | Track onboarding events | P0 | S | 1 |
| US-11 | Re-engagement email at 24h | P1 | M | 1 |

## 4. Scope

### In Scope
- Welcome screen with value proposition and personalization question (role selection)
- Step-by-step guided flow to create first [core object]
- Progress bar / checklist UI component
- Skip and resume capability
- Onboarding state persistence (database-backed)
- Analytics events for every step
- 24-hour re-engagement email for incomplete onboarding
- Empty states that nudge toward onboarding completion

### Out of Scope
- Video tutorials (planned for Phase 2; will use static illustrations for Phase 1)
- Interactive product tours of the full UI (this is a guided action flow, not a tooltip tour)
- A/B testing framework (will use feature flags for now; full experimentation in Phase 2)
- Onboarding for mobile/native apps (web only for Phase 1)
- Custom onboarding flows per pricing tier
- Admin customization of onboarding steps (Phase 3)

### Future Considerations
- Branching onboarding paths based on role/persona selection
- Integration with third-party onboarding tools (Appcues, Pendo) for non-engineering iteration
- Onboarding analytics dashboard for product team self-serve analysis
- Gamification elements (badges, streaks) tied to onboarding completion

## 5. Detailed Requirements

### 5.1 Welcome Screen
**Description**: The first screen a user sees after email verification. It welcomes the user by name, communicates the core value proposition in one sentence, and asks a single personalization question (their role/use case) to tailor the subsequent flow.

**Acceptance Criteria**:
- [ ] Displays user's first name (from sign-up) in the greeting
- [ ] Shows a single-sentence value proposition
- [ ] Presents 3-5 role/use-case options as selectable cards (not a dropdown)
- [ ] Selection is optional -- user can proceed without choosing
- [ ] Selection is stored in user profile for downstream personalization
- [ ] Screen loads in under 500ms (no heavy assets)
- [ ] Responsive: works on viewports from 375px to 2560px wide

**UI/UX Notes**:
- Clean, minimal design. No navigation chrome -- this is a full-screen takeover.
- Illustration or subtle animation to convey warmth, not a wall of text.
- "Skip" link is present but visually de-emphasized (bottom-right, muted text).
- States: Default, Loading (skeleton), Error (retry prompt).

**Data Model**:
- New field on `users` table: `onboarding_role` (enum, nullable)
- New field on `users` table: `onboarding_status` (enum: `not_started`, `in_progress`, `completed`, `skipped`)
- New field on `users` table: `onboarding_current_step` (integer, default 0)
- New field on `users` table: `onboarding_completed_at` (timestamp, nullable)

**API**:
- `PATCH /api/v1/users/me/onboarding` -- update onboarding role, step, status
- Request: `{ "role": "manager" | "individual" | "admin" | "other", "current_step": 1 }`
- Response: `{ "onboarding_status": "in_progress", "current_step": 1 }`

### 5.2 Guided Core Action Flow
**Description**: A 3-5 step wizard that walks the user through creating their first meaningful [core object] in the product. Each step has clear instructions, inline validation, and contextual help. The flow is designed to get the user to their first "aha moment" as quickly as possible.

**Acceptance Criteria**:
- [ ] Flow consists of exactly 3-5 steps (determined by role selection; default is 4 steps)
- [ ] Each step has: a title, a 1-sentence description, an action area, and a "Why this matters" tooltip
- [ ] Inline validation provides feedback within 300ms of input
- [ ] User can navigate backward to previous steps without losing data
- [ ] Completing the final step creates a real [core object] (not a dummy/sample)
- [ ] After completion, user lands on the [core object] detail view with a celebration moment
- [ ] Each step auto-saves progress on blur/navigation so nothing is lost
- [ ] If the user has been invited to a team, step 1 is pre-populated with team context

**UI/UX Notes**:
- Wizard layout: narrow centered column (max-width 640px), generous whitespace.
- Progress bar at top shows steps as numbered circles with labels.
- Active step is highlighted; completed steps show a checkmark.
- Transitions between steps use a subtle slide animation (200ms).
- Celebration on completion: confetti animation (lightweight, CSS-only) and a congratulatory message.
- States per step: Empty, Active (user is filling in), Validating, Error, Completed.

**Data Model**:
- No new tables for the wizard itself -- it creates a standard [core object] using existing tables.
- Onboarding step progress tracked via `onboarding_current_step` on the `users` table.
- New table: `onboarding_step_events` for granular analytics:
  - `id` (UUID, PK)
  - `user_id` (FK to users)
  - `step_number` (integer)
  - `step_name` (string)
  - `action` (enum: `started`, `completed`, `skipped`, `errored`)
  - `duration_seconds` (integer, nullable)
  - `metadata` (JSONB, nullable)
  - `created_at` (timestamp)

**API**:
- `POST /api/v1/onboarding/steps/:stepNumber/complete` -- marks a step complete, advances progress
- Request: `{ "metadata": { ... } }`
- Response: `{ "next_step": 3, "onboarding_status": "in_progress" }`
- `GET /api/v1/onboarding/state` -- returns full onboarding state for the current user
- Response: `{ "status": "in_progress", "current_step": 2, "role": "manager", "steps": [...] }`

### 5.3 Progress Checklist (Persistent)
**Description**: After the initial onboarding wizard, a persistent checklist appears in the product sidebar/dashboard that tracks broader activation milestones (e.g., "Invite a team member", "Connect an integration", "Complete your profile"). This keeps the user engaged beyond the initial wizard.

**Acceptance Criteria**:
- [ ] Checklist displays 5-7 activation milestones
- [ ] Milestones auto-complete when the user takes the corresponding action anywhere in the product
- [ ] Checklist is visible on the dashboard and collapsible in the sidebar
- [ ] Completing all milestones triggers a final celebration and hides the checklist permanently
- [ ] User can dismiss the checklist early; a "Resume setup" option persists in settings
- [ ] Checklist state syncs in real-time (if user completes an action in another tab, the checklist updates)

**UI/UX Notes**:
- Dashboard: card-style checklist with progress ring showing percentage complete.
- Sidebar: compact list with checkmarks; collapses to a single "3 of 7 complete" badge.
- Each item has a CTA button that deep-links to the relevant part of the product.
- Dismissed state is stored per-user and respected across sessions.

**Data Model**:
- New table: `onboarding_milestones`
  - `id` (UUID, PK)
  - `user_id` (FK to users)
  - `milestone_key` (string, e.g., `invite_team_member`)
  - `completed_at` (timestamp, nullable)
  - `dismissed_at` (timestamp, nullable)

**API**:
- `GET /api/v1/onboarding/milestones` -- returns milestone state for the current user
- `POST /api/v1/onboarding/milestones/:key/complete` -- marks a milestone complete
- `POST /api/v1/onboarding/milestones/dismiss` -- dismisses the entire checklist

### 5.4 Re-engagement Email
**Description**: If a user does not complete onboarding within 24 hours of sign-up, a single re-engagement email is sent. The email is personalized based on where the user dropped off and includes a deep link to resume.

**Acceptance Criteria**:
- [ ] Email is sent exactly once, 24 hours after sign-up, only if onboarding is incomplete
- [ ] Email subject and body reference the specific step where the user stopped
- [ ] Email contains a one-click deep link that logs the user in and resumes onboarding at the correct step
- [ ] Email respects the user's communication preferences (unsubscribe honored)
- [ ] Email open rate and click-through rate are tracked
- [ ] Email is not sent if the user has already completed onboarding or deleted their account

**UI/UX Notes**:
- Plain-text-friendly HTML email (responsive, single column, max 600px).
- Tone: helpful and encouraging, not pushy.
- CTA button: "Pick up where you left off" (links to onboarding step).

**Data Model**:
- Leverages existing email/notification queue infrastructure.
- New scheduled job entry: `onboarding_reengagement_24h`.
- Tracking via existing email event table (open, click, unsubscribe).

**API**:
- No new public API endpoints. Internal job triggers `POST /internal/emails/send` with template `onboarding_reengagement`.

## 6. Technical Design

### Architecture Overview
The onboarding flow is a frontend-driven wizard that communicates with the existing API layer. No new microservices are needed. The frontend stores step state locally (for responsiveness) and syncs to the backend on each step completion. The re-engagement email is handled by the existing background job system.

Reference: [ARCHITECTURE.md](../ARCHITECTURE.md) for the full system architecture.

### Database Changes
| Change Type | Table/Collection | Description | Migration Notes |
|-------------|-----------------|-------------|-----------------|
| Modify | `users` | Add `onboarding_role`, `onboarding_status`, `onboarding_current_step`, `onboarding_completed_at` | Non-breaking; all fields nullable or have defaults. Backfill existing users as `completed` (they pre-date onboarding). |
| New | `onboarding_step_events` | Analytics events for each onboarding step | Append-only, no FK constraints on hot path. Partition by month. |
| New | `onboarding_milestones` | Persistent checklist state per user | Unique constraint on `(user_id, milestone_key)`. |

### API Changes
| Method | Endpoint | Description | Auth | Rate Limit |
|--------|----------|-------------|------|------------|
| GET | `/api/v1/onboarding/state` | Get current user's onboarding state | Authenticated user | 60/min |
| PATCH | `/api/v1/users/me/onboarding` | Update onboarding role/step | Authenticated user | 30/min |
| POST | `/api/v1/onboarding/steps/:stepNumber/complete` | Mark onboarding step complete | Authenticated user | 30/min |
| GET | `/api/v1/onboarding/milestones` | Get milestone checklist state | Authenticated user | 60/min |
| POST | `/api/v1/onboarding/milestones/:key/complete` | Mark a milestone complete | Authenticated user | 30/min |
| POST | `/api/v1/onboarding/milestones/dismiss` | Dismiss the milestone checklist | Authenticated user | 10/min |

### Frontend Components
| Component | Type | Description | Dependencies |
|-----------|------|-------------|--------------|
| `OnboardingProvider` | New (Context) | Manages onboarding state, syncs with API | React Context, API client |
| `WelcomeScreen` | New (Page) | Full-screen welcome with role selection | `OnboardingProvider` |
| `OnboardingWizard` | New (Page) | Multi-step wizard container | `OnboardingProvider`, `StepProgressBar` |
| `StepProgressBar` | New (Component) | Visual progress indicator | None |
| `OnboardingStep` | New (Component) | Generic step wrapper (title, description, action area) | `OnboardingProvider` |
| `MilestoneChecklist` | New (Component) | Dashboard checklist card | `OnboardingProvider` |
| `SidebarMilestones` | New (Component) | Compact sidebar milestone list | `MilestoneChecklist` |
| `CelebrationOverlay` | New (Component) | Confetti + congratulations on completion | CSS animations |

### Third-Party Integrations
| Service | Purpose | Fallback Strategy | Cost Impact |
|---------|---------|-------------------|-------------|
| Email provider (existing) | Send re-engagement email | Queue and retry; alert after 3 failures | Negligible (1 email per user) |
| Analytics (existing) | Track onboarding events | Local event buffer; flush on reconnect | No additional cost |

### Caching Strategy
- Onboarding state is cached in-memory on the frontend (React state/context). Backend is the source of truth.
- `GET /api/v1/onboarding/state` response is cached server-side per user with a 60-second TTL; invalidated on any write to onboarding endpoints.
- Milestone definitions (the list of available milestones) are cached globally with a 1-hour TTL since they change only on deployment.

## 7. Edge Cases & Error Handling
| # | Scenario | Likelihood | Impact | Expected Behavior | Test Coverage |
|---|----------|-----------|--------|-------------------|---------------|
| 1 | User refreshes mid-step | High | Low | Auto-saved state is restored; user resumes from last saved point | E2E |
| 2 | User opens onboarding in two tabs | Medium | Medium | Last-write-wins; both tabs reflect latest state on next API call | Integration |
| 3 | User signs up via OAuth and has no first name | Medium | Low | Welcome screen says "Welcome!" without a name; no blank greeting | Unit |
| 4 | User is invited to a team but the team is deleted before they onboard | Low | Medium | Fall back to individual onboarding flow; log warning | Integration |
| 5 | Re-engagement email is triggered but user completed onboarding seconds before | Medium | Low | Job checks `onboarding_status` immediately before sending; skips if complete | Unit |
| 6 | User's session expires during onboarding wizard | Medium | Medium | On 401 response, redirect to login with `?redirect=/onboarding` to resume after re-auth | E2E |
| 7 | API is unreachable during step completion | Low | High | Frontend retries 3 times with exponential backoff; shows error toast with manual retry button after exhaustion | Integration |
| 8 | User has JavaScript disabled | Low | High | Server-rendered fallback page with link to enable JS; onboarding requires JS | Manual QA |
| 9 | User completes a milestone action via API (not UI) | Medium | Low | Milestone completion is triggered by backend event, not UI; works regardless of entry point | Integration |
| 10 | Concurrent milestone completion (webhook + user action simultaneously) | Low | Low | Unique constraint on `(user_id, milestone_key)` with upsert handles gracefully | Unit |

## 8. Security Considerations
- [x] All onboarding endpoints require authenticated session (JWT or session cookie)
- [x] Users can only read/write their own onboarding state (enforced by extracting `user_id` from auth token, never from request body)
- [x] The one-click deep link in the re-engagement email uses a time-limited token (expires 72 hours after issuance, single use)
- [x] Onboarding role selection input is validated server-side against allowed enum values
- [x] Rate limiting on all onboarding endpoints prevents abuse (see API table above)
- [ ] Audit log entries are created for onboarding completion and milestone dismissal (for customer success visibility)
- [x] No PII is stored in the `onboarding_step_events` table beyond `user_id` -- no free-text input is logged

## 9. Performance Requirements
| Dimension | Requirement | Measurement |
|-----------|-------------|-------------|
| Welcome screen load (p50) | < 300ms | Lighthouse lab test + RUM |
| Welcome screen load (p99) | < 1s | RUM percentile dashboard |
| Step transition (p50) | < 200ms (perceived) | Optimistic UI; API call is background |
| Step completion API (p50) | < 150ms | Server-side latency tracking |
| Step completion API (p99) | < 500ms | Server-side latency tracking |
| Milestone check query | < 50ms | Database query plan analysis |
| Onboarding state payload | < 5KB | API response size monitoring |
| Concurrent onboarding users | Support 500 simultaneous | Load test with k6 |

## 10. Rollout Plan

### Pre-Launch
- [x] Feature flag `onboarding_v2` created and tested in staging
- [x] Monitoring dashboard created: onboarding funnel, error rates, latency
- [x] Alerting configured: error rate > 5% triggers PagerDuty
- [x] Runbook documented for on-call (how to disable onboarding, how to manually advance a stuck user)

### Phase 1: Internal Dogfood (Week 1)
- [x] Enable for all internal team members creating new test accounts
- [x] Collect qualitative feedback via Slack channel #onboarding-dogfood
- [x] Success criteria to proceed: no P0 bugs, team NPS > 7

### Phase 2: New Sign-Ups -- 10% (Weeks 2-3)
- [ ] Enable for 10% of new sign-ups via feature flag
- [ ] Monitor activation rate vs. control group
- [ ] Success criteria to proceed: activation rate improvement is statistically significant (p < 0.05) and > 10% relative improvement

### Phase 3: New Sign-Ups -- 100% (Weeks 4+)
- [ ] Enable for all new sign-ups
- [ ] Disable old onboarding flow (keep code for 30 days in case of rollback)
- [ ] Rollback criteria: activation rate drops below control baseline OR error rate exceeds 2%

### Phase 4: Existing Users (Week 6+)
- [ ] Show milestone checklist to existing users who signed up in the last 90 days and have not completed key activation milestones
- [ ] Do NOT show the initial wizard to existing users -- only the persistent checklist

### Post-Launch
- [ ] Monitor success metrics daily for 2 weeks, then weekly
- [ ] Collect qualitative feedback via in-app survey (shown after onboarding completion)
- [ ] Retrospective scheduled for Week 8
- [ ] Publish findings to internal product blog

## 11. Dependencies

### Upstream (we depend on)
| Dependency | Type | Status | Risk | Mitigation |
|-----------|------|--------|------|------------|
| Email service (transactional) | Hard | Ready | Low | Already in production; re-engagement uses existing infrastructure |
| Feature flag service | Hard | Ready | Low | Already in production; new flag only |
| Analytics pipeline | Soft | Ready | Low | Events are fire-and-forget; onboarding works even if analytics is down |
| Design system components | Soft | In Progress | Medium | 80% of needed components exist; progress bar and celebration overlay are new |

### Downstream (depends on us)
| Dependent | Impact | Communication Plan |
|-----------|--------|-------------------|
| Growth team A/B testing | Will use onboarding funnel as a test surface | Shared onboarding event schema with growth team; they can build experiments on top |
| Customer Success | Will use milestone completion data for outreach | CS team briefed; Slack notification on milestone stall for high-value accounts |
| Data/Analytics team | Will build onboarding cohort dashboards | Schema review completed; analytics team approved event taxonomy |

## 12. Open Questions
| # | Question | Owner | Due Date | Resolution |
|---|----------|-------|----------|------------|
| 1 | Should we allow admins to customize the onboarding steps for their team? | Jane (PM) | 2025-04-15 | Deferred to Phase 3. For now, all teams see the same flow. |
| 2 | What is the ideal number of steps? Literature suggests 3-5. | Mike (UX) | 2025-04-01 | Resolved: 4 steps for default flow. Will A/B test 3 vs 4 vs 5 in Phase 2. |
| 3 | Should we gate any features behind onboarding completion? | Jane (PM) | 2025-04-10 | Resolved: No gating. Onboarding is encouraged but never required. |
| 4 | How do we handle users who sign up, never onboard, but come back 30 days later? | Jane (PM) | 2025-04-20 | Open. Options: show onboarding again, show abbreviated version, or just show the milestone checklist. |

## 13. Appendix

### References
- [Nielsen Norman Group: Onboarding UX Patterns](https://www.nngroup.com) (internal research summary)
- [Reforge: Activation Rate Deep Dive](https://www.reforge.com) (team has access)
- Session recordings of 50 new user sessions (tagged in FullStory workspace "Onboarding Research Q1")
- Support ticket analysis: Zendesk export, filtered by tag `getting-started` (Q1 data)

### Changelog
| Date | Author | Change Description |
|------|--------|-------------------|
| 2025-03-15 | Jane Chen | Initial draft |
| 2025-03-22 | Jane Chen | Added milestone checklist (Section 5.3) based on eng feedback |
| 2025-03-28 | Mike Torres | Updated UI/UX notes with design system component mapping |
| 2025-04-01 | Jane Chen | Resolved open question #2 (step count); updated rollout plan with phase dates |
| 2025-04-02 | Jane Chen | Marked as Approved after product review sign-off |
