# Launch Tracker Template

> One canonical, evidence-based status file for every app you are launching.
> Copy to `docs/LAUNCH_TRACKER.md` (or a shared playbook repo) and fill it in.
> Rules come from the [Web to Mobile Launch Playbook](../guides/WEB_TO_MOBILE_LAUNCH_PLAYBOOK.md).

**Rules**

- Evidence order: live dashboard or database, then CI run URL, then dated entry, then summaries.
- A gate is `Done` only with evidence cited. Otherwise `UNVERIFIED`.
- Newer dated entries supersede older ones.
- No evidence in 7 days: mark `Stale`.
- Every session that moves a gate edits this file.
- Human-only gates are listed separately. Agents report them and never act.

States: `Done` | `In progress` | `Not done` | `UNVERIFIED` | `Stale`

---

## Portfolio (priority order)

| Priority | App | Platforms | State | Last evidence (date) | Next action | Owner |
|---|---|---|---|---|---|---|
| 1 | [APP_NAME] | iOS, Android, Web | [state] | [date + source] | [one action] | [name] |
| 2 | | | | | | |

Keep one row per app. Priority tiers are a stated choice by the owner, not inferred.

---

## Publisher Gates (shared across all apps)

| Gate | State | Date started | Date done | Evidence |
|---|---|---|---|---|
| Legal entity | | | | |
| Business identifier (D-U-N-S) | | | | |
| Apple Developer Program (org) | | | | |
| Apple agreements, banking, tax | | | | |
| Apple EU trader status | | | | |
| Google Play Console account | | | | |
| Google Play identity / org verification | | | | |
| Google Play post-verification wait or testing requirement | | | | |
| Domain, support email, privacy URL | | | | |

---

## Per-App Gate Table

Copy this block for each app.

### [APP_NAME]

| Gate | iOS | Android | Evidence / date |
|---|---|---|---|
| Permanent app id chosen and owned | | | |
| Known-green CI config in place | | | CI run URL |
| Signed build produced | | | Build number, run URL |
| Artifact inspected (signed, target SDK, id) | | | |
| RC tagged | | | Tag |
| Installed on a real device from the beta channel | | | Device, OS, date |
| Billing reconciled (ids, types, server, webhook) | | | |
| Sandbox purchase, restore, cancel | | | Entitlement row ids |
| Account deletion tested end to end | | | |
| Reviewer login from empty account | | | |
| Pre-release copy removed | | | Search output |
| Store listing and screenshots from the RC | | | |
| Privacy label / Data Safety answered | | | |
| Price and availability set | | | |
| Declarations complete | | | |
| Pre-flight clean (submission flow clicked through) | | | |
| Submitted | | | Timestamp |
| Approved | | | Timestamp |
| Released | | | Timestamp |

---

## Human-Only Items

| Item | Who | Status |
|---|---|---|
| Agreements, banking, tax, trader declarations | | |
| Typing sandbox and reviewer credentials | | |
| Dragging local files into a console | | |
| Final Submit for Review | | |
| Release (if manual) | | |
| Anything the agent could not verify (secrets, env vars) | | |

---

## Accepted Risks

| Risk | Owner | Date accepted | Mitigation |
|---|---|---|---|
| | | | |

---

## Decisions Log

| Date | Decision | Why | Record |
|---|---|---|---|
| | e.g. Free on Android, in-app purchase on iOS | | `decisions/...` |

---

## Session Log

Newest first. One line per session.

```text
YYYY-MM-DD HH:MM  [who]  What changed, which gate moved, evidence link.
```

---

## Continuation Instructions (for the next agent)

1. Read this file top to bottom.
2. Live-check the consoles that matter today. Update any row you verify.
3. Do not submit. Report remaining human-only items.
4. Work the portfolio in priority order, starting with the first row that is not Done.
5. Record lessons in `docs/ai-agents/LESSONS_LEARNED.md` and promote repeats to a rule or skill.
