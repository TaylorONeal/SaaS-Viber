# PRD-[NUMBER]: [Feature Name]

> **Status**: Draft | In Review | Approved | In Development | Shipped
> **Author**: [Name]
> **Created**: [Date]
> **Last Updated**: [Date]
> **Phase**: [Roadmap Phase Reference]

---

## 1. Problem Statement
<!-- What problem does this feature solve? Who has this problem? How painful is it? -->

[TEMPLATE: Describe the user pain point in 2-3 sentences. Reference user research or support tickets if available.]

**Impact Assessment**:
- **Users Affected**: [Percentage or segment of user base]
- **Frequency**: [How often users encounter this problem]
- **Severity**: Critical | High | Medium | Low
- **Current Workaround**: [How users solve this today, if at all]

## 2. Goals & Success Metrics

### Goals
- [ ] [Primary goal -- the single most important outcome]
- [ ] [Secondary goal -- supporting outcome]
- [ ] [Tertiary goal -- nice-to-have outcome]

### Success Metrics
| Metric | Current Baseline | Target | Timeframe | Measurement Method |
|--------|-----------------|--------|-----------|-------------------|
| [Metric name] | [Current value] | [Target value] | [e.g., 30 days post-launch] | [Tool/query/method] |
| [Metric name] | [Current value] | [Target value] | [e.g., 90 days post-launch] | [Tool/query/method] |

### Anti-Goals
<!-- What are we explicitly NOT trying to achieve? -->
- [Anti-goal: something this feature should not become or optimize for]

## 3. User Stories

### [Role 1: e.g., End User]
- As a [role], I want to [action] so that [benefit]
- As a [role], I want to [action] so that [benefit]
- As a [role], I want to [action] so that [benefit]

### [Role 2: e.g., Admin]
- As a [role], I want to [action] so that [benefit]
- As a [role], I want to [action] so that [benefit]

### [Role 3: e.g., System/Automated]
- As the system, I need to [action] so that [benefit]

**Priority Matrix**:
| Story ID | User Story (short) | Priority | Effort | Phase |
|----------|-------------------|----------|--------|-------|
| US-1 | [Short description] | P0/P1/P2 | S/M/L/XL | [Phase] |

## 4. Scope

### In Scope
- [Feature or capability included in this work]
- [Feature or capability included in this work]

### Out of Scope
- [Explicitly excluded -- state why if non-obvious]
- [Explicitly excluded -- state why if non-obvious]

### Future Considerations
<!-- Things we are deferring but want to design for extensibility -->
- [Future capability we want to keep the door open for]
- [Future capability we want to keep the door open for]

## 5. Detailed Requirements

### 5.1 [Requirement Area]
**Description**: [What this requirement area covers and why it matters]

**Acceptance Criteria**:
- [ ] [Criterion -- specific, testable, unambiguous]
- [ ] [Criterion -- specific, testable, unambiguous]
- [ ] [Criterion -- specific, testable, unambiguous]

**UI/UX Notes**:
- [Link to design mockup or description of interaction]
- [Key states: empty, loading, error, success, edge case]

**Data Model**:
- [New tables or fields needed]
- [Relationships and constraints]

**API**:
- [New endpoints: method, path, request/response shape]
- [Modified endpoints: what changes]

### 5.2 [Requirement Area]
<!-- Repeat the pattern above for each major requirement area -->

**Description**: [What this requirement area covers]

**Acceptance Criteria**:
- [ ] [Criterion]
- [ ] [Criterion]

**UI/UX Notes**: [Details]
**Data Model**: [Details]
**API**: [Details]

## 6. Technical Design

### Architecture Overview
<!-- High-level approach. Reference ARCHITECTURE.md for system-wide context. -->
[Brief description of the technical approach and where it fits in the overall system]

### Database Changes
| Change Type | Table/Collection | Description | Migration Notes |
|-------------|-----------------|-------------|-----------------|
| New | [table name] | [purpose] | [migration considerations] |
| Modify | [table name] | [what changes] | [backward compatibility notes] |

### API Changes
| Method | Endpoint | Description | Auth | Rate Limit |
|--------|----------|-------------|------|------------|
| [GET/POST/etc.] | [/api/v1/resource] | [What it does] | [Auth level] | [Limit] |

### Frontend Components
| Component | Type | Description | Dependencies |
|-----------|------|-------------|--------------|
| [ComponentName] | New/Modified | [What it does] | [Other components] |

### Third-Party Integrations
| Service | Purpose | Fallback Strategy | Cost Impact |
|---------|---------|-------------------|-------------|
| [Service name] | [Why needed] | [What happens if unavailable] | [Estimated cost] |

### Caching Strategy
- [What to cache, TTL, invalidation strategy]

## 7. Edge Cases & Error Handling
| # | Scenario | Likelihood | Impact | Expected Behavior | Test Coverage |
|---|----------|-----------|--------|-------------------|---------------|
| 1 | [Edge case description] | High/Med/Low | High/Med/Low | [How the system should respond] | [Unit/Integration/E2E] |
| 2 | [Edge case description] | High/Med/Low | High/Med/Low | [How the system should respond] | [Unit/Integration/E2E] |

## 8. Security Considerations
- [ ] [Authentication requirement -- who can access this feature]
- [ ] [Authorization requirement -- role-based access details]
- [ ] [Data protection -- PII handling, encryption needs]
- [ ] [Input validation -- what inputs need sanitization]
- [ ] [Audit logging -- what actions need to be recorded]
- [ ] [Compliance -- GDPR, SOC2, HIPAA if applicable]

## 9. Performance Requirements
| Dimension | Requirement | Measurement |
|-----------|-------------|-------------|
| Latency (p50) | [e.g., < 200ms] | [How measured] |
| Latency (p99) | [e.g., < 1s] | [How measured] |
| Throughput | [e.g., 100 req/s] | [How measured] |
| Database | [e.g., No N+1 queries] | [How verified] |
| Payload size | [e.g., < 50KB response] | [How measured] |
| Concurrent users | [e.g., Support 1000 simultaneous] | [Load test plan] |

## 10. Rollout Plan

### Pre-Launch
- [ ] Feature flag created and tested
- [ ] Monitoring and alerting configured
- [ ] Runbook documented for on-call

### Phase 1: Internal / Beta
- [ ] [Description -- who gets access, success criteria to proceed]
- [ ] Duration: [Timeframe]

### Phase 2: Gradual Rollout
- [ ] [Description -- percentage rollout, monitoring checkpoints]
- [ ] Duration: [Timeframe]

### Phase 3: General Availability
- [ ] [Description -- full rollout, documentation published]
- [ ] Rollback criteria: [What triggers a rollback]

### Post-Launch
- [ ] Monitor success metrics for [timeframe]
- [ ] Collect user feedback via [channel]
- [ ] Retrospective scheduled for [date]

## 11. Dependencies

### Upstream (we depend on)
| Dependency | Type | Status | Risk | Mitigation |
|-----------|------|--------|------|------------|
| [Feature/Service] | Hard/Soft | Ready/In Progress/Blocked | High/Med/Low | [Plan] |

### Downstream (depends on us)
| Dependent | Impact | Communication Plan |
|-----------|--------|-------------------|
| [Feature/Team] | [What is affected] | [How we will coordinate] |

## 12. Open Questions
| # | Question | Owner | Due Date | Resolution |
|---|----------|-------|----------|------------|
| 1 | [Question that needs resolution] | [Who decides] | [When needed by] | [Answer when resolved] |
| 2 | [Question that needs resolution] | [Who decides] | [When needed by] | [Answer when resolved] |

## 13. Appendix

### References
- [Link to related documents, research, competitor analysis]

### Changelog
| Date | Author | Change Description |
|------|--------|-------------------|
| [Date] | [Name] | [What changed in this PRD] |
