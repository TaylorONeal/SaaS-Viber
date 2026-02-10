# Prioritized Next Steps — [YOUR_APP_NAME]

> **Purpose:** A prioritized, actionable list of what to do next. This is the "what should
> I work on today?" document. Updated regularly based on roadmap progress, bugs, and
> changing priorities.
>
> **Last Updated:** [DATE]
> **Current Phase:** [Phase 1: MVP / Phase 2: Growth / Phase 3: Scale / Phase 4: Expand]

---

## Priority Matrix

> Use the Impact vs Effort matrix to prioritize next steps. Place each item in the
> appropriate quadrant to decide what to do first.

```
                    HIGH IMPACT
                        │
         ┌──────────────┼──────────────┐
         │              │              │
         │   QUICK      │   MAJOR      │
         │   WINS       │   PROJECTS   │
         │              │              │
         │   Do First   │  Plan & Do   │
         │              │              │
LOW ─────┼──────────────┼──────────────┼───── HIGH
EFFORT   │              │              │  EFFORT
         │   FILL-INS   │   CONSIDER   │
         │              │   CAREFULLY  │
         │   Do When    │              │
         │   Free       │  Deprioritize│
         │              │   or Delegate│
         └──────────────┼──────────────┘
                        │
                    LOW IMPACT
```

### Quick Wins (High Impact, Low Effort)
> Do these first. Maximum value for minimum investment.

| # | Task | Impact | Effort | Owner | Deadline |
|---|---|---|---|---|---|
| 1 | [Task description] | [Why it matters] | [Hours/Days] | [Person] | [Date] |
| 2 | [Task description] | [Why it matters] | [Hours/Days] | [Person] | [Date] |
| 3 | [Task description] | [Why it matters] | [Hours/Days] | [Person] | [Date] |

### Major Projects (High Impact, High Effort)
> Plan these carefully. Break them into smaller tasks and schedule them.

| # | Task | Impact | Effort | Owner | Target Sprint |
|---|---|---|---|---|---|
| 1 | [Task description] | [Why it matters] | [Days/Weeks] | [Person] | [Sprint #] |
| 2 | [Task description] | [Why it matters] | [Days/Weeks] | [Person] | [Sprint #] |
| 3 | [Task description] | [Why it matters] | [Days/Weeks] | [Person] | [Sprint #] |

### Fill-Ins (Low Impact, Low Effort)
> Do these when you have spare cycles or need a break from major work.

| # | Task | Impact | Effort | Owner |
|---|---|---|---|---|
| 1 | [Task description] | [Minor improvement] | [Hours] | [Person] |
| 2 | [Task description] | [Minor improvement] | [Hours] | [Person] |

### Deprioritized (Low Impact, High Effort)
> Tracked but not actively pursued. Revisit quarterly.

| # | Task | Why Deprioritized | Revisit Date |
|---|---|---|---|
| 1 | [Task description] | [Reason] | [Date] |
| 2 | [Task description] | [Reason] | [Date] |

---

## MoSCoW Prioritization

### Must Have
> Critical for the current phase. The product cannot ship without these.

- [ ] **[MUST-1]:** [Description]
  - Depends on: [Dependencies]
  - Estimated effort: [Time]
  - Acceptance criteria: [What "done" looks like]

- [ ] **[MUST-2]:** [Description]
  - Depends on: [Dependencies]
  - Estimated effort: [Time]
  - Acceptance criteria: [What "done" looks like]

- [ ] **[MUST-3]:** [Description]
  - Depends on: [Dependencies]
  - Estimated effort: [Time]
  - Acceptance criteria: [What "done" looks like]

### Should Have
> Important but not critical. Strongly expected in this phase.

- [ ] **[SHOULD-1]:** [Description]
  - Depends on: [Dependencies]
  - Estimated effort: [Time]
  - Risk if deferred: [What happens if we skip this]

- [ ] **[SHOULD-2]:** [Description]
  - Depends on: [Dependencies]
  - Estimated effort: [Time]
  - Risk if deferred: [What happens if we skip this]

- [ ] **[SHOULD-3]:** [Description]
  - Depends on: [Dependencies]
  - Estimated effort: [Time]
  - Risk if deferred: [What happens if we skip this]

### Nice to Have
> Desirable but can be deferred without significant impact.

- [ ] **[NICE-1]:** [Description]
  - Value add: [Why it would be nice]
  - Estimated effort: [Time]

- [ ] **[NICE-2]:** [Description]
  - Value add: [Why it would be nice]
  - Estimated effort: [Time]

---

## This Week's Focus

> Updated at the start of each week. No more than 3-5 items.

**Week of [DATE]:**

| Priority | Task | Status | Owner | Notes |
|---|---|---|---|---|
| 1 | [Most important task] | [Not Started / In Progress / Done] | [Person] | [Notes] |
| 2 | [Second task] | [Status] | [Person] | [Notes] |
| 3 | [Third task] | [Status] | [Person] | [Notes] |
| 4 | [Fourth task] | [Status] | [Person] | [Notes] |
| 5 | [Fifth task] | [Status] | [Person] | [Notes] |

### Blocked Items
| Task | Blocked By | Unblock Action | Who Can Unblock |
|---|---|---|---|
| [Task] | [Blocker description] | [What needs to happen] | [Person/Team] |

---

## Decision Log

> Decisions that affect next steps. Capture the "why" so future-you understands.

| Date | Decision | Rationale | Impact on Next Steps |
|---|---|---|---|
| [DATE] | [Decision made] | [Why this choice] | [How it changes priorities] |
| [DATE] | [Decision made] | [Why this choice] | [How it changes priorities] |

---

## Completed Items

> Move items here when done. Keeps a record of progress.

| # | Task | Completed Date | Notes |
|---|---|---|---|
| 1 | [Completed task] | [DATE] | [Any follow-up needed] |
| 2 | [Completed task] | [DATE] | [Any follow-up needed] |

---

## Tracking Template

### Adding a New Item

When adding a new next step:

1. **Assess impact:** How many users does this affect? Does it unblock other work?
2. **Assess effort:** How many hours/days? Any unknowns that increase risk?
3. **Place in matrix:** Quick Win, Major Project, Fill-In, or Deprioritize?
4. **Assign MoSCoW:** Must Have, Should Have, or Nice to Have for current phase?
5. **Set owner and deadline:** Who is responsible? When should it be done?
6. **Add dependencies:** What needs to happen first?

### Weekly Review Process

Every [Monday / start of sprint]:

1. Review the current week's focus items
2. Move completed items to the "Completed" section
3. Identify blockers and assign unblock actions
4. Pull new items from the priority matrix into this week's focus
5. Update STATUS.md with any status changes
6. Update FEATURE_INDEX.md if features changed status

---

## Prompt Guide Reference

```
Review the current state of [YOUR_APP_NAME] based on:
- docs/STATUS.md (what's working, what's not)
- docs/ROADMAP.md (current phase and goals)
- docs/FEATURE_INDEX.md (feature statuses)

Generate a prioritized list of next steps following the template in docs/NEXT_STEPS.md.
For each item:
1. Assess impact (High/Medium/Low) based on phase goals
2. Estimate effort in developer-days
3. Place in the Impact vs Effort matrix
4. Assign MoSCoW priority for the current phase
5. Identify dependencies and blockers

Focus on items that:
- Unblock other high-priority work
- Close the gap between current state and phase exit criteria
- Address critical bugs or technical debt
- Have the highest impact-to-effort ratio
```

---

*Status: Template*
*Next review: [DATE]*
