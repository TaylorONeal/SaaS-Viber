# PRD Implementation Audit

> **Purpose**: Systematically track the implementation status of every feature defined in the PRD system. This document provides a living audit of what has been specified, what has been built, and where gaps exist.
>
> **Last Audited**: [Date]
> **Audited By**: [Name]
> **Next Audit Due**: [Date]

---

## How to Use This Document

1. **Before each sprint/cycle**: Review the audit table for your focus area. Identify gaps between PRD and implementation.
2. **After each release**: Update the status columns for all affected features.
3. **During retrospectives**: Use the gap analysis to surface systemic issues (e.g., "we consistently ship without tests").
4. **For prioritization**: Use the priority scoring matrix to decide what gaps to close first.

---

## 1. Feature-by-Feature Audit

### Status Legend
| Code | Meaning | Description |
|------|---------|-------------|
| **N/A** | Not Applicable | This dimension does not apply to this feature |
| **--** | Not Started | Work has not begun |
| **SPEC** | Specified | Requirements are written but no implementation exists |
| **WIP** | Work in Progress | Actively being built; not yet functional |
| **PARTIAL** | Partially Complete | Some functionality works; gaps remain |
| **DONE** | Complete | Fully implemented and verified |
| **DRIFT** | Implementation Drift | Implementation has diverged from the PRD specification |
| **DEBT** | Technical Debt | Works but has known quality/architecture issues |

### Core Platform Features

| # | Feature | PRD Status | Schema Status | UI Status | Backend Status | Integration Status | Test Status | Notes |
|---|---------|-----------|---------------|-----------|---------------|-------------------|-------------|-------|
| 1 | [Feature name] | [SPEC/DONE/--] | [--/WIP/DONE/...] | [--/WIP/DONE/...] | [--/WIP/DONE/...] | [N/A/--/WIP/DONE/...] | [--/WIP/DONE/...] | [Brief note] |
| 2 | [Feature name] | | | | | | | |
| 3 | [Feature name] | | | | | | | |
| 4 | [Feature name] | | | | | | | |
| 5 | [Feature name] | | | | | | | |

### Domain-Specific Features

| # | Feature | PRD Status | Schema Status | UI Status | Backend Status | Integration Status | Test Status | Notes |
|---|---------|-----------|---------------|-----------|---------------|-------------------|-------------|-------|
| 6 | [Feature name] | | | | | | | |
| 7 | [Feature name] | | | | | | | |
| 8 | [Feature name] | | | | | | | |

### Growth & Engagement Features

| # | Feature | PRD Status | Schema Status | UI Status | Backend Status | Integration Status | Test Status | Notes |
|---|---------|-----------|---------------|-----------|---------------|-------------------|-------------|-------|
| 9 | [Feature name] | | | | | | | |
| 10 | [Feature name] | | | | | | | |

### Integration & API Features

| # | Feature | PRD Status | Schema Status | UI Status | Backend Status | Integration Status | Test Status | Notes |
|---|---------|-----------|---------------|-----------|---------------|-------------------|-------------|-------|
| 11 | [Feature name] | | | | | | | |
| 12 | [Feature name] | | | | | | | |

---

## 2. Detailed Gap Analysis

### Gap Analysis Template

For each gap identified in the audit above, create a detailed entry below.

---

#### GAP-[NUMBER]: [Short Description]

| Attribute | Detail |
|-----------|--------|
| **Feature** | [Which feature from the audit table] |
| **PRD Reference** | [Link to specific PRD section] |
| **Gap Type** | Missing / Incomplete / Diverged / Quality |
| **Dimension** | Schema / UI / Backend / Integration / Test |
| **Severity** | Critical / High / Medium / Low |
| **Description** | [What was specified vs. what exists (or does not exist)] |
| **User Impact** | [How this gap affects users today] |
| **Risk if Unresolved** | [What happens if we do not fix this] |
| **Estimated Effort** | XS / S / M / L / XL |
| **Recommended Action** | [Specific next step] |
| **Owner** | [Who should resolve this] |
| **Target Date** | [When it should be resolved] |
| **Resolution** | [Filled in when resolved] |

---

#### GAP-001: [Example -- No input validation on settings form]

| Attribute | Detail |
|-----------|--------|
| **Feature** | User Settings |
| **PRD Reference** | [PRD-005, Section 5.2](./PRD-005.md#52-settings-form) |
| **Gap Type** | Incomplete |
| **Dimension** | Backend |
| **Severity** | High |
| **Description** | PRD specifies server-side validation for all settings fields (email format, display name length 1-100 chars, timezone from IANA list). Current implementation accepts any string for all fields. |
| **User Impact** | Users can save invalid data that causes downstream errors (e.g., malformed email breaks notification delivery). |
| **Risk if Unresolved** | Data integrity issues; potential security vector via oversized payloads. |
| **Estimated Effort** | S |
| **Recommended Action** | Add Zod/Joi schema validation to `PATCH /api/v1/users/me/settings` endpoint. |
| **Owner** | [Backend engineer] |
| **Target Date** | [Date] |
| **Resolution** | -- |

---

#### GAP-002: [Example placeholder]

[Use the template above]

---

## 3. Audit Summary Dashboard

### Overall Completion by Dimension

| Dimension | Total Features | DONE | PARTIAL | WIP | SPEC Only | Not Started | Drift | Debt |
|-----------|---------------|------|---------|-----|-----------|-------------|-------|------|
| **PRD** | [N] | [n] | [n] | [n] | -- | [n] | -- | -- |
| **Schema** | [N] | [n] | [n] | [n] | [n] | [n] | [n] | [n] |
| **UI** | [N] | [n] | [n] | [n] | [n] | [n] | [n] | [n] |
| **Backend** | [N] | [n] | [n] | [n] | [n] | [n] | [n] | [n] |
| **Integration** | [N] | [n] | [n] | [n] | [n] | [n] | [n] | [n] |
| **Tests** | [N] | [n] | [n] | [n] | [n] | [n] | [n] | [n] |

### Completion Percentage
```
PRD Spec Coverage:   [██████████░░░░░░░░░░] XX%
Schema:              [████████░░░░░░░░░░░░] XX%
UI:                  [██████░░░░░░░░░░░░░░] XX%
Backend:             [████████░░░░░░░░░░░░] XX%
Integration:         [████░░░░░░░░░░░░░░░░] XX%
Tests:               [██░░░░░░░░░░░░░░░░░░] XX%
```

### Gap Severity Distribution
| Severity | Count | Percentage |
|----------|-------|-----------|
| Critical | [n] | [%] |
| High | [n] | [%] |
| Medium | [n] | [%] |
| Low | [n] | [%] |

---

## 4. Priority Scoring Matrix

Use this matrix to prioritize which gaps to close first. Score each gap on the dimensions below, then sort by total score (highest priority first).

### Scoring Criteria

| Dimension | Weight | 1 (Low) | 2 (Medium) | 3 (High) |
|-----------|--------|---------|-----------|----------|
| **User Impact** | 3x | Cosmetic or rare edge case | Affects workflow but has workaround | Blocks core functionality or affects many users |
| **Revenue Impact** | 3x | No revenue effect | Could affect conversion or retention indirectly | Directly causes churn or blocks revenue |
| **Security Risk** | 3x | No security implication | Minor risk with low exploitability | Data exposure, auth bypass, or compliance violation |
| **Technical Risk** | 2x | Isolated; no cascading effects | Could cause issues in related features | Systemic risk; affects multiple features or data integrity |
| **Effort (inverse)** | 1x | XL effort (weeks) | M effort (days) | XS/S effort (hours) |
| **Dependency** | 1x | Nothing depends on this | Some features are partially blocked | Multiple features or teams are blocked |

### Priority Score Table

| Gap ID | User Impact (x3) | Revenue Impact (x3) | Security Risk (x3) | Technical Risk (x2) | Effort Inverse (x1) | Dependency (x1) | **Total Score** | **Rank** |
|--------|-----------------|--------------------|--------------------|--------------------|--------------------|-----------------|----------------|----------|
| GAP-001 | [1-3] x3 = [n] | [1-3] x3 = [n] | [1-3] x3 = [n] | [1-3] x2 = [n] | [1-3] x1 = [n] | [1-3] x1 = [n] | **[total]** | [#] |
| GAP-002 | | | | | | | | |
| GAP-003 | | | | | | | | |

### Priority Tiers
After scoring, group gaps into tiers:

| Tier | Score Range | Action | Timeline |
|------|------------|--------|----------|
| **P0 -- Fix Now** | 30+ | Drop everything; fix in current sprint | This week |
| **P1 -- Fix Soon** | 20-29 | Schedule in next sprint | Next 2 weeks |
| **P2 -- Plan Fix** | 12-19 | Add to backlog with target date | Next 4-6 weeks |
| **P3 -- Track** | < 12 | Document and revisit next audit cycle | Next quarter |

---

## 5. Audit Process

### Audit Cadence
| Audit Type | Frequency | Scope | Owner |
|-----------|-----------|-------|-------|
| **Full Audit** | Quarterly | All features, all dimensions | Product + Engineering Lead |
| **Sprint Audit** | Every sprint | Features touched in the sprint | Sprint lead |
| **Release Audit** | Every release | Features included in the release | Release manager |
| **Ad-Hoc Audit** | As needed | Specific feature or area of concern | Requestor |

### Audit Checklist
For each feature being audited, verify the following:

#### PRD Status
- [ ] PRD exists and is up to date
- [ ] Acceptance criteria are specific and testable
- [ ] Edge cases are documented
- [ ] Security considerations are addressed

#### Schema Status
- [ ] All required tables/collections exist
- [ ] Fields match PRD data model specification
- [ ] Constraints (unique, not null, foreign keys) are in place
- [ ] Indexes exist for query patterns described in PRD
- [ ] Migrations are reversible

#### UI Status
- [ ] All screens/views specified in PRD are implemented
- [ ] All states are handled (empty, loading, error, success)
- [ ] Responsive behavior matches requirements
- [ ] Accessibility requirements are met (WCAG 2.1 AA minimum)
- [ ] UI matches design specifications or approved deviations are documented

#### Backend Status
- [ ] All API endpoints specified in PRD are implemented
- [ ] Request/response shapes match PRD specification
- [ ] Input validation is implemented server-side
- [ ] Error responses follow the API error contract
- [ ] Rate limiting is configured as specified
- [ ] Authorization checks are in place

#### Integration Status
- [ ] Third-party integrations function correctly
- [ ] Fallback behavior works when integrations are unavailable
- [ ] Webhooks/callbacks are implemented as specified
- [ ] Data flows between systems are verified

#### Test Status
- [ ] Unit tests cover business logic
- [ ] Integration tests cover API endpoints
- [ ] E2E tests cover critical user paths
- [ ] Edge cases from PRD Section 7 have corresponding tests
- [ ] Performance tests validate PRD Section 9 requirements
- [ ] Test coverage meets team threshold (e.g., > 80%)

---

## 6. Historical Audit Log

| Audit Date | Type | Auditor | Total Gaps Found | Critical | Resolved Since Last | Summary |
|-----------|------|---------|-----------------|----------|--------------------|---------||
| [Date] | [Full/Sprint/Release] | [Name] | [Count] | [Count] | [Count] | [One-line summary] |

---

## Appendix

### Related Documents
- [PRD-TEMPLATE.md](./PRD-TEMPLATE.md) -- Master PRD template
- [EDGE_CASES.md](./EDGE_CASES.md) -- Cross-feature edge cases
- Individual PRDs: [PRD-001](./PRD-001-example.md), [PRD-002], etc.

### Changelog
| Date | Author | Change |
|------|--------|--------|
| [Date] | [Name] | [Initial creation / update description] |
