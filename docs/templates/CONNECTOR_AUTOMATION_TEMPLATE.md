# Connector and Automation Safety Template

> Use this template when adding imports, exports, integrations, bulk actions, AI agents, cleanup jobs, or any workflow that reads or changes user-owned data.

## 1. Workflow Summary

| Field | Answer |
|---|---|
| Workflow name | `[WORKFLOW_NAME]` |
| User goal | `[WHAT_THE_USER_IS_TRYING_TO_ACCOMPLISH]` |
| Data sources | `[GMAIL/CALENDAR/CSV/API/WEBHOOK/MANUAL_UPLOAD/OTHER]` |
| Data changed | `[NONE / DRAFTS / RECORDS / BILLING / EMAIL / FILES / OTHER]` |
| Reversibility | `[FULLY_REVERSIBLE / PARTIAL / IRREVERSIBLE]` |
| Approval required | `[YES/NO_AND_WHY]` |

## 2. Connector Contract

Each connector should produce normalized objects instead of leaking source-specific fields into the product.

| Layer | Requirement | Owner |
|---|---|---|
| Source read | Define scopes, permissions, and rate limits | `[OWNER]` |
| Normalization | Map source fields to stable internal objects | `[OWNER]` |
| Validation | Reject malformed, stale, or incomplete records | `[OWNER]` |
| Dedupe | Detect duplicates across imports and reminders | `[OWNER]` |
| Storage | Mark sensitive fields and retention rules | `[OWNER]` |
| Export | Provide portable output format | `[OWNER]` |

## 3. Safety Rules

### Never-touch list

Ask the user or admin for protected entities before the first run.

- `[PROTECTED_PERSON_OR_ACCOUNT_TYPE]`
- `[PROTECTED_RECORD_TYPE]`
- `[PROTECTED_VENDOR_OR_INSTITUTION]`
- `[PROTECTED_STATUS_OR_TAG]`

### Preview requirements

Before applying changes, show:

- Total records scanned.
- Total records that would change.
- Representative examples.
- Borderline cases.
- Records skipped because of never-touch rules.
- How to undo or restore.

### Action policy

| Action type | Default policy |
|---|---|
| Read-only enrichment | Allowed after permission grant |
| Draft creation | Allowed, but clearly marked as draft |
| Internal record update | Preview first, then confirm |
| Bulk archive or cleanup | Soft-action only, with restore path |
| External send | Human approval required |
| Billing or plan change | Human approval required |
| Permission or role change | Human approval required |
| Permanent deletion | Avoid by default; require explicit confirmation and audit log |

## 4. Human-in-the-Loop Gates

| Gate | Required when | Approval artifact |
|---|---|---|
| Setup approval | First run, new connector, new scope | `[CHECKBOX / ADMIN_SETTING / LOG_EVENT]` |
| Preview approval | Any bulk change | `[APPROVAL_EVENT]` |
| Exception approval | Borderline or low-confidence cases | `[QUEUE_OR_REVIEW_RECORD]` |
| Launch approval | New automation moves from draft to scheduled | `[CHANGE_REQUEST]` |
| Incident approval | Restore, rollback, or user notification needed | `[INCIDENT_RECORD]` |

## 5. Audit Log Fields

Capture enough detail to explain and reverse an action.

| Field | Example |
|---|---|
| `action_id` | `act_123` |
| `workflow_name` | `[WORKFLOW_NAME]` |
| `actor_type` | `user`, `admin`, `agent`, `system` |
| `actor_id` | `[ID]` |
| `source_connector` | `gmail`, `calendar`, `csv`, `api` |
| `records_scanned` | `1280` |
| `records_changed` | `42` |
| `approval_id` | `[APPROVAL_EVENT_ID]` |
| `revert_plan` | `[HOW_TO_RESTORE]` |
| `created_at` | `[TIMESTAMP]` |

## 6. Launch Checklist

- [ ] Connector permissions are minimal and documented.
- [ ] Sensitive fields are identified and excluded from logs where possible.
- [ ] Preview mode works without side effects.
- [ ] Never-touch rules override every automation rule.
- [ ] Dedupe logic handles repeated imports and reminders.
- [ ] User-facing copy explains what will and will not happen.
- [ ] Audit logs are queryable by support or admins.
- [ ] Restore or rollback path has been tested.
- [ ] Export format is documented.
- [ ] Error handling reports skipped, failed, and partial actions clearly.

