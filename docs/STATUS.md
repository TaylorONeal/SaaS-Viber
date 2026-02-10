# Project Status — [YOUR_APP_NAME]

> **Purpose:** A living snapshot of where the project stands right now.
> Update this document at the end of each sprint or major milestone.
>
> **Last Updated:** [DATE]
> **Sprint/Iteration:** [SPRINT_NUMBER]

---

## Current State Summary

| Category | Count | Details |
|---|---|---|
| Features Working | [X] | See "Working" section below |
| Features In Progress | [X] | See "In Progress" section below |
| Features Not Started | [X] | See "Not Started" section below |
| Critical Bugs | [X] | See "Known Issues" section below |
| Technical Debt Items | [X] | See "Technical Debt" section below |

---

## Working

> Features that are built, tested, and functioning in the current environment.

| Feature | Environment | Last Tested | Notes |
|---|---|---|---|
| [Feature 1] | Development | [DATE] | [Any caveats] |
| [Feature 2] | Staging | [DATE] | [Any caveats] |
| [Feature 3] | Production | [DATE] | — |

### Details

#### [Feature 1]
- **What works:** [Description of working functionality]
- **Limitations:** [Known limitations or scope restrictions]
- **Dependencies:** [External services, APIs, etc.]

#### [Feature 2]
- **What works:** [Description]
- **Limitations:** [Description]
- **Dependencies:** [Description]

---

## In Progress

> Features currently being developed or partially complete.

| Feature | Assigned To | Started | Target Completion | % Complete | Blocker? |
|---|---|---|---|---|---|
| [Feature A] | [Person/Team] | [DATE] | [DATE] | [X]% | [Yes/No] |
| [Feature B] | [Person/Team] | [DATE] | [DATE] | [X]% | [Yes/No] |
| [Feature C] | [Person/Team] | [DATE] | [DATE] | [X]% | [Yes/No] |

### Details

#### [Feature A]
- **Current state:** [What has been built so far]
- **Remaining work:** [What still needs to be done]
- **Blockers:** [If any — describe the blocker and what unblocks it]

#### [Feature B]
- **Current state:** [Description]
- **Remaining work:** [Description]
- **Blockers:** [Description]

---

## Not Started

> Features that are planned but have not been started yet.

| Feature | Priority | Phase | Depends On | PRD |
|---|---|---|---|---|
| [Feature X] | High | Phase 1 | [Dependencies] | [Link to PRD] |
| [Feature Y] | Medium | Phase 2 | [Dependencies] | [Link to PRD] |
| [Feature Z] | Low | Phase 3 | [Dependencies] | [Link to PRD] |

---

## Technical Debt Tracker

> Items that are "good enough for now" but need to be addressed before scale.

| ID | Description | Severity | Impact | Estimated Effort | Target Phase |
|---|---|---|---|---|---|
| TD-001 | [Description of debt item] | High | [What happens if ignored] | [Hours/Days] | Phase [X] |
| TD-002 | [Description] | Medium | [Impact] | [Effort] | Phase [X] |
| TD-003 | [Description] | Low | [Impact] | [Effort] | Phase [X] |

### Severity Definitions
- **High:** Will cause production issues or block features if not addressed
- **Medium:** Slows development or degrades performance; address within 2 sprints
- **Low:** Code quality or developer experience; address when convenient

### Common Technical Debt Categories
- [ ] Hardcoded values that should be configurable
- [ ] Missing error handling or edge cases
- [ ] Placeholder implementations (mock data, stub functions)
- [ ] Missing tests (unit, integration, e2e)
- [ ] Performance optimizations deferred
- [ ] Security hardening deferred
- [ ] Accessibility improvements needed
- [ ] Database indexes or query optimizations
- [ ] Logging and monitoring gaps

---

## Known Issues

> Bugs, defects, and unexpected behaviors that have been identified.

| ID | Description | Severity | Reproducible? | Workaround | Assigned |
|---|---|---|---|---|---|
| BUG-001 | [Description] | Critical | Yes | [Workaround if any] | [Person] |
| BUG-002 | [Description] | Major | Yes | [Workaround] | [Person] |
| BUG-003 | [Description] | Minor | Intermittent | None | Unassigned |

### Severity Definitions
- **Critical:** Application is unusable or data loss occurs
- **Major:** Feature is broken but workaround exists
- **Minor:** Cosmetic or non-blocking issue
- **Trivial:** Typo, minor UI glitch

---

## Environment Status

| Environment | URL | Status | Last Deploy | Version |
|---|---|---|---|---|
| Development | [URL or localhost] | [Up/Down] | [DATE] | [VERSION] |
| Staging | [URL] | [Up/Down] | [DATE] | [VERSION] |
| Production | [URL] | [Up/Down] | [DATE] | [VERSION] |

---

## Path to Production Checklist

> Track readiness for production launch. Check items as they are completed.

### Infrastructure
- [ ] Hosting environment provisioned
- [ ] Domain name configured
- [ ] SSL certificates installed
- [ ] CDN configured (if needed)
- [ ] Database provisioned and secured
- [ ] Environment variables set (no secrets in code)
- [ ] Backup strategy implemented and tested
- [ ] Monitoring and alerting configured

### Security
- [ ] Authentication system tested
- [ ] Authorization / RBAC verified
- [ ] Input validation on all endpoints
- [ ] SQL injection protection verified
- [ ] XSS protection verified
- [ ] CSRF protection enabled
- [ ] Rate limiting configured
- [ ] Secrets management in place (not in repo)
- [ ] Security headers configured
- [ ] Dependency vulnerability scan clean

### Quality
- [ ] Unit tests passing ([X]% coverage)
- [ ] Integration tests passing
- [ ] End-to-end tests passing
- [ ] Performance benchmarks met
- [ ] Accessibility audit passed (WCAG 2.1 AA)
- [ ] Cross-browser testing completed
- [ ] Mobile responsive testing completed
- [ ] Error handling verified for all user flows

### Legal & Compliance
- [ ] Privacy policy published
- [ ] Terms of service published
- [ ] Cookie consent implemented (if applicable)
- [ ] GDPR compliance verified (if applicable)
- [ ] Data processing agreements in place
- [ ] Compliance framework requirements met (see [AUDIT_COMPLIANCE.md](./architecture/AUDIT_COMPLIANCE.md))

### Operations
- [ ] Deployment pipeline configured (CI/CD)
- [ ] Rollback procedure documented and tested
- [ ] Incident response plan documented
- [ ] On-call rotation established (if applicable)
- [ ] Runbook for common operations
- [ ] Log aggregation configured
- [ ] Health check endpoints working

### Business
- [ ] Payment processing tested with real transactions
- [ ] Billing webhooks verified
- [ ] Subscription lifecycle tested end-to-end
- [ ] Cancellation and refund flow working
- [ ] Analytics and tracking configured
- [ ] Support channel established
- [ ] Launch communication plan ready

---

## Status History

> Log major status changes for a historical record.

| Date | Change | Notes |
|---|---|---|
| [DATE] | Project initialized | Template documentation created |
| [DATE] | [Milestone reached] | [Details] |
| [DATE] | [Major change] | [Details] |

---

## Prompt Guide Reference

> Use the following prompt to generate a status update from your codebase:

See [PromptGuide-Architecture.md](./architecture/PromptGuide-Architecture.md) for AI-assisted documentation prompts.

**Quick Status Prompt:**
```
Review the current codebase at [YOUR_REPO_PATH] and generate a project status
report following the template in docs/STATUS.md. For each feature, determine
whether it is Working, In Progress, or Not Started based on:
- Working: Has tests, is integrated, functions end-to-end
- In Progress: Has partial implementation, is missing tests or integration
- Not Started: Is mentioned in PRDs but has no implementation
Also identify any technical debt and known issues.
```

---

*Status: Template*
*Next review: [DATE]*
