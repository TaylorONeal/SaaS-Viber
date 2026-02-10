# Edge Cases Documentation

> **Purpose**: A centralized reference for edge cases common to SaaS applications. Use this document as a starting checklist when writing PRDs, designing features, or writing test plans. Each category contains pre-populated scenarios that apply to most SaaS products, plus a template for adding domain-specific cases.
>
> **Last Updated**: [Date]
> **Owner**: [Engineering Lead / QA Lead]

---

## How to Use This Document

1. **When writing a PRD**: Scan the categories relevant to your feature. Copy applicable scenarios into your PRD's Section 7 (Edge Cases & Error Handling).
2. **When writing tests**: Use this as a test case generation checklist. Every scenario marked as High impact should have at least one automated test.
3. **When reviewing code**: Verify that the implementation handles the scenarios relevant to the changed code paths.
4. **When adding new edge cases**: Use the template format below. Add them to the appropriate category, or create a new category if none fits.

### Scenario Template
| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| [ID] | [What happens] | [What causes it] | Critical/High/Med/Low | High/Med/Low | [How to handle] | Unit/Integration/E2E/Manual | Covered/Gap |

**Impact Definitions**:
- **Critical**: Data loss, security breach, financial error, or complete feature failure
- **High**: Feature is unusable or produces incorrect results for affected users
- **Medium**: Feature works but with degraded experience; workaround exists
- **Low**: Cosmetic or rare; minimal user impact

---

## 1. Authentication & Session Management

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| AUTH-01 | Session expires during active form submission | JWT/cookie TTL expires while user is filling out a long form | High | High | Silently refresh token before expiry (sliding window). If refresh fails, save form state to localStorage, redirect to login, restore on re-auth. | E2E | |
| AUTH-02 | User logs in on two devices; logs out on one | Session revocation on Device A while Device B is active | Medium | High | On next API call from Device B, return 401. Frontend handles gracefully with redirect to login. Do not destroy unsaved work. | Integration | |
| AUTH-03 | OAuth provider is temporarily unavailable | Third-party auth provider (Google, GitHub, etc.) returns 5xx | High | Low | Show clear error message ("Sign-in provider is temporarily unavailable. Please try again or use email/password."). Implement retry with backoff. Do not display raw error. | Integration | |
| AUTH-04 | User changes email address used for OAuth | User changes their Google email, then tries to log in | High | Low | Match on provider + provider user ID, not email. If mismatch detected, prompt user to link accounts or contact support. | Integration | |
| AUTH-05 | Brute-force login attempts | Attacker tries many password combinations | Critical | Medium | Rate limit login attempts per IP (10/min) and per account (5/min). After threshold, require CAPTCHA. After 20 failures, temporarily lock account with email notification. | Integration | |
| AUTH-06 | Password reset token used after expiry | User clicks reset link hours/days later | Medium | Medium | Token has 1-hour TTL. Show clear "This link has expired" message with option to request a new one. Never reveal whether the email exists. | Unit | |
| AUTH-07 | User deletes account then tries to sign up with same email | Soft-deleted account conflicts with new registration | Medium | Low | If using soft delete: check deleted accounts on sign-up. Option A: re-activate (dangerous). Option B: allow new account with new UUID (preferred). Ensure old data is truly purged. | Integration | |
| AUTH-08 | CSRF token mismatch on form submission | User has stale tab open, CSRF token rotated | Medium | Medium | Return 403 with clear message. Frontend reloads CSRF token and retries automatically (once). If it fails again, prompt user to refresh. | Integration | |
| AUTH-09 | SSO user tries to use password login | User's org enforces SSO but user tries email/password | Low | Medium | Detect domain, redirect to SSO flow with message "Your organization requires single sign-on." Do not reveal that the password is valid/invalid. | Unit | |
| AUTH-10 | Concurrent password changes | User changes password in two tabs simultaneously | Low | Low | Last write wins. Both sessions except the winning one are invalidated. User must re-login with new password. | Unit | |

---

## 2. Payments & Billing

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| PAY-01 | Payment fails during subscription creation | Card declined, insufficient funds, 3D Secure abandonment | Critical | High | Do not provision paid features until payment confirmed. Show clear error with specific reason from payment provider. Allow retry. Keep user on free tier. | Integration | |
| PAY-02 | Recurring payment fails (involuntary churn) | Card expired, insufficient funds on renewal day | Critical | High | Implement dunning sequence: retry at day 1, 3, 5, 7. Send email on each failure. Grace period (7-14 days) before downgrade. Update card prompt in-app. | Integration | |
| PAY-03 | User downgrades mid-billing cycle | User switches from Pro to Free mid-month | High | Medium | Prorate remaining balance as credit. Immediately restrict access to Pro features, or allow access until end of billing period (business decision -- document which). | Integration | |
| PAY-04 | User upgrades mid-billing cycle | User switches from Free to Pro mid-month | High | Medium | Charge prorated amount for remaining days. Grant Pro access immediately. Ensure no double-charge on next renewal. | Integration | |
| PAY-05 | Webhook arrives out of order | Stripe sends `invoice.paid` before `customer.subscription.created` | High | Medium | Make webhook handlers idempotent. Use event timestamps, not arrival order, to determine state. Implement event reconciliation job that runs hourly. | Integration | |
| PAY-06 | Duplicate webhook delivery | Payment provider sends the same event twice | High | Medium | Store processed event IDs. Check for duplicates before processing. Return 200 to acknowledge even if duplicate (to prevent infinite retries from provider). | Unit | |
| PAY-07 | Currency mismatch | User in EUR region; product priced in USD | Medium | Medium | Display prices in user's local currency where possible. Clearly show which currency will be charged. Handle FX rate fluctuations in display vs. actual charge. | Unit | |
| PAY-08 | Tax calculation error | VAT/GST/sales tax computed incorrectly for user's jurisdiction | Critical | Low | Use a tax calculation service (Stripe Tax, TaxJar). Never hardcode tax rates. Log all tax calculations for audit. Reconcile monthly. | Integration | |
| PAY-09 | Refund requested after plan change | User pays, upgrades, requests refund of original charge | Medium | Low | Define refund policy clearly. Refund via payment provider API (not manual). Adjust subscription state accordingly. Log refund reason. | Manual | |
| PAY-10 | Free trial expires with no payment method | Trial ends; user never added a card | High | High | Send reminder emails at day 3, 1, and 0 before expiry. On expiry: downgrade to free tier. Do not delete data. Show clear upgrade prompt with value messaging. | E2E | |
| PAY-11 | Subscription created but webhook never arrives | Network failure between payment provider and your server | Critical | Low | Implement polling reconciliation job that checks payment provider API for recent subscriptions every 15 minutes. Alert if discrepancy found. | Integration | |
| PAY-12 | User disputes charge (chargeback) | User files chargeback with their bank | Critical | Low | Receive chargeback webhook. Optionally restrict account. Prepare evidence for dispute. Track chargeback rate (must stay below 1% for payment provider compliance). | Manual | |

---

## 3. Data Integrity & Storage

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| DATA-01 | User submits form with Unicode edge cases | Emoji, RTL text, zero-width characters, extremely long strings | Medium | Medium | Validate string length in bytes (not just characters). Normalize Unicode (NFC). Set max lengths at DB and API level. Test rendering with RTL and mixed-direction text. | Unit | |
| DATA-02 | Concurrent edits to the same resource | Two users edit the same record simultaneously | High | Medium | Option A: Optimistic locking with version field (return 409 Conflict on stale write). Option B: Last-write-wins with conflict notification. Option C: Operational transforms (complex). Choose based on feature criticality. | Integration | |
| DATA-03 | Orphaned records after parent deletion | Parent record deleted but child records remain (broken FK) | High | Medium | Use cascading deletes where appropriate. For soft deletes, ensure queries filter on `deleted_at IS NULL`. Run periodic orphan detection job. | Integration | |
| DATA-04 | Database migration fails mid-way | Deployment interrupted during schema migration | Critical | Low | All migrations must be reversible. Use transactional DDL where supported. Test migrations against production-size dataset in staging. Have rollback runbook. | Manual | |
| DATA-05 | File upload exceeds size limit | User uploads a 500MB file when limit is 10MB | Low | High | Validate file size client-side (immediate feedback) AND server-side (security). Return 413 with clear message and the actual limit. Reject before fully receiving the body (streaming check). | Unit | |
| DATA-06 | Malformed CSV/data import | User imports CSV with wrong delimiters, encoding issues, or malformed rows | Medium | High | Validate file structure before processing. Show preview of parsed data. Report row-level errors. Allow partial import with error log. Never silently skip rows. | Integration | |
| DATA-07 | Data export while data is being modified | User requests export while another process is writing | Medium | Low | Use snapshot isolation or read replica for exports. Timestamp the export. Document that export reflects a point-in-time snapshot, not real-time. | Integration | |
| DATA-08 | User requests account data export (GDPR) | User exercises right to data portability | High | Low | Provide automated self-serve export. Include all PII and user-generated content. Format as machine-readable (JSON/CSV). Complete within 30 days (legal requirement). Log the request. | E2E | |
| DATA-09 | User requests account deletion (GDPR) | User exercises right to erasure | Critical | Low | Soft delete immediately (remove from UI). Hard delete PII within 30 days. Retain anonymized analytics data. Handle cascading effects (team membership, shared resources). Cannot be undone -- confirm with user. | E2E | |
| DATA-10 | Bulk operation on large dataset | User selects "all" (10,000+ records) for a bulk action | High | Medium | Implement background job processing for operations above threshold (e.g., 100 records). Show progress indicator. Allow cancellation. Send email/notification on completion. Do not block the UI. | Integration | |

---

## 4. Concurrency & Race Conditions

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| RACE-01 | Double form submission | User clicks submit twice rapidly | High | High | Disable submit button on first click. Backend: use idempotency keys. Return same response for duplicate requests within a time window. | Unit + E2E | |
| RACE-02 | Two users claim the same unique resource | Two users try to reserve the same username/slug simultaneously | Medium | Medium | Database unique constraint is the final arbiter. Application-level check first (for UX), but do not rely on it for correctness. Return clear "already taken" message on constraint violation. | Integration | |
| RACE-03 | Webhook and user action modify same resource simultaneously | Payment webhook updates subscription while user modifies account settings | High | Medium | Use row-level locking (SELECT FOR UPDATE) for critical writes. Alternatively, use optimistic locking with retry. Ensure webhook and user-facing code use the same locking strategy. | Integration | |
| RACE-04 | Background job processes stale data | Job reads data, processes for 30 seconds, writes result -- but data changed during processing | Medium | Medium | Re-validate state before final write. Use version/timestamp check. If stale, re-queue for reprocessing. Log the conflict. | Unit | |
| RACE-05 | Rate limiter key collision | Different users hash to the same rate limit bucket | Low | Low | Use user ID (not IP alone) as rate limit key for authenticated endpoints. IP-based limiting for unauthenticated endpoints. Monitor for false positives. | Unit | |
| RACE-06 | Distributed lock expiry during long operation | Lock TTL expires while operation is still running; another process acquires the lock | Critical | Low | Set lock TTL longer than expected max operation time. Implement lock renewal (heartbeat). On lock loss, abort operation gracefully. Alert on lock contention. | Integration | |

---

## 5. Timezone & Date/Time Handling

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| TZ-01 | User in UTC-12 and admin in UTC+12 see different "today" | 26-hour window where "today" is ambiguous | Medium | High | Store all timestamps in UTC. Convert to user's timezone for display only. Never use server local time. Be explicit about which timezone is used in any date display. | Unit | |
| TZ-02 | Daylight saving time transition | Scheduled event falls on a DST boundary (spring forward / fall back) | High | Medium | Use timezone-aware datetime libraries (e.g., `luxon`, `date-fns-tz`, `pytz`). Never add/subtract raw hours for timezone conversion. Test specifically at DST boundaries. | Unit | |
| TZ-03 | User changes their timezone setting | User moves from US/Eastern to Europe/London; existing data should not shift | Medium | Low | Stored timestamps are in UTC (unaffected). Display layer re-renders with new timezone. Calendar/scheduling features: clarify whether existing events shift or stay at their original wall-clock time (this is a product decision). | Unit | |
| TZ-04 | Billing cycle on the 31st of the month | February, April, June, September, November do not have a 31st | Medium | High | Pin to "last day of month" if the anchor day does not exist. Use the payment provider's built-in billing anchor logic where possible. Document the behavior. | Unit | |
| TZ-05 | Midnight cron job and timezone assumptions | Nightly job runs at "midnight" but whose midnight? | Medium | Medium | Run cron jobs in UTC. If business logic requires "midnight in user's timezone," schedule per-user or per-org jobs. Document which timezone the cron runs in. | Integration | |
| TZ-06 | Leap seconds and unusual calendar events | Feb 29 in non-leap year; leap second | Low | Low | Use well-tested datetime libraries that handle these. Do not implement date math manually. Validate date inputs. | Unit | |
| TZ-07 | Relative time display inaccuracy | "5 minutes ago" displayed but user's system clock is wrong | Low | Medium | Use server timestamp for relative time calculations, not client clock. Or accept minor inaccuracy and document the limitation. | Unit | |

---

## 6. Permissions & Access Control

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| PERM-01 | User role downgraded while in active session | Admin removes user's elevated permissions | Critical | Medium | Check permissions on every API request (not just at login). Cache permissions with short TTL (< 5 min). Invalidate cache on role change. | Integration | |
| PERM-02 | Last admin removes themselves from the organization | Only admin demotes themselves or deletes their account | High | Low | Prevent last-admin removal at the application level. Display clear error: "You are the only admin. Assign another admin before removing yourself." | Unit | |
| PERM-03 | Shared link accessed by unauthorized user | User shares a URL to a restricted resource with someone who does not have access | Critical | High | Every resource access checks permissions server-side (not just hiding UI elements). Return 403 with "You don't have access. Request access from [owner]." Never return the data with a hidden UI. | E2E | |
| PERM-04 | Permission check on bulk operation | User has permission for some but not all items in a bulk operation | Medium | Medium | Option A: Fail the entire batch (strict). Option B: Process permitted items, skip forbidden ones, return detailed report. Document which strategy is used. | Integration | |
| PERM-05 | API key used after user deactivation | API key was generated by a user who is no longer active | Critical | Low | Tie API key validity to user account status. Check user status on API key authentication. Revoke all keys when user is deactivated. | Integration | |
| PERM-06 | Cross-tenant data access attempt | User manipulates IDs in API requests to access another tenant's data | Critical | Medium | Always scope queries by `tenant_id` / `org_id` derived from the authenticated session -- never from user input. Implement tenant isolation at the query layer (middleware). Penetration test regularly. | Integration | |
| PERM-07 | Invitation accepted after being revoked | Admin sends invite, revokes it, but user clicks the original link | Low | Low | Validate invitation status on acceptance (not just token validity). Return clear message: "This invitation is no longer valid." | Unit | |
| PERM-08 | Role escalation via API manipulation | User modifies their own role in a PATCH request to their profile | Critical | Medium | Never accept role changes from the user's own update endpoint. Role changes require admin-level endpoint with separate authorization. Ignore role field in user self-update. | Unit | |

---

## 7. Network & Infrastructure

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| NET-01 | API request timeout | Slow database query, downstream service latency | High | Medium | Set appropriate timeouts at each layer (client: 30s, API gateway: 25s, application: 20s, database: 15s). Return 504 with retry guidance. Implement circuit breakers for downstream calls. | Integration | |
| NET-02 | Rate limit exceeded | Legitimate user hits rate limit during normal use | Medium | Medium | Set limits generously for authenticated users. Return 429 with `Retry-After` header. Show clear message in UI. Provide higher limits for paid tiers. Monitor for limits that are too aggressive. | Unit | |
| NET-03 | CDN cache serves stale content after deployment | Asset cache not invalidated after frontend deploy | High | Medium | Use content-hashed filenames for assets. Set appropriate cache headers. Implement cache-busting strategy for HTML documents. Test cache invalidation as part of deploy process. | Manual | |
| NET-04 | WebSocket/SSE connection dropped | Network interruption, server restart, load balancer timeout | Medium | High | Implement automatic reconnection with exponential backoff. Re-sync state on reconnect (not just resume from where left off). Show "reconnecting..." indicator in UI. | Integration | |
| NET-05 | DNS resolution failure | DNS provider outage | Critical | Low | Use multiple DNS providers. Set appropriate TTLs. Monitor DNS resolution from external locations. Have runbook for DNS failover. | Manual | |
| NET-06 | Request body too large | User sends payload exceeding server limit | Low | Medium | Set explicit body size limits at the API gateway and application level. Return 413 with clear message and the actual limit. Validate on client side first. | Unit | |

---

## 8. Email & Notifications

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| EMAIL-01 | Transactional email delayed or not delivered | Email provider queue backup, spam filter, invalid address | High | Medium | Use a reputable transactional email provider. Monitor delivery rates. Implement fallback provider. Log all send attempts. Do not make critical flows depend solely on email delivery (provide in-app fallback). | Integration | |
| EMAIL-02 | User receives notification for a resource they no longer have access to | Permission changed after notification was queued but before delivery | Medium | Medium | Re-check permissions at notification render/delivery time (not just queue time). If access is revoked, suppress the notification. | Unit | |
| EMAIL-03 | Notification flood | System bug or legitimate event triggers hundreds of notifications for one user | High | Low | Implement per-user notification rate limiting (e.g., max 10 emails/hour). Batch similar notifications. Alert engineering if rate limit is hit (may indicate a bug). | Unit | |
| EMAIL-04 | Push notification to logged-out device | User logged out but push token is still registered | Low | Medium | Clean up push tokens on logout. Gracefully handle push delivery failures. Remove tokens after N consecutive delivery failures. | Unit | |
| EMAIL-05 | Email contains stale data | Email queued with a preview of data that changed before the email was opened | Medium | High | Include minimal data in email body. Use "View in app" links for details. If email must contain data, note that it reflects the state at time of sending. | Unit | |

---

## 9. Search & Filtering

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| SRCH-01 | Search query returns no results | User misspells or searches for content that does not exist | Medium | High | Show helpful empty state: "No results for 'xyz'. Try a different search." Suggest corrections if possible. Do not show a blank page. | E2E | |
| SRCH-02 | Search injection / XSS via search query | User enters `<script>alert('xss')</script>` in search | Critical | Medium | Sanitize all search inputs. Escape output. Use parameterized queries. Content Security Policy headers. | Unit | |
| SRCH-03 | Extremely long search query | User pastes a wall of text into the search box | Low | Low | Set max query length (e.g., 500 characters). Truncate or reject with clear message. Do not pass unbounded input to the search engine. | Unit | |
| SRCH-04 | Filter combination returns empty set | User applies multiple filters that exclude all records | Medium | High | Show "No items match your filters" with an option to clear filters. Show filter counts if feasible so users know which filter is too restrictive. | E2E | |
| SRCH-05 | Search index is stale | Recently created/modified content does not appear in search results | Medium | Medium | Document expected indexing delay. Implement near-real-time indexing for critical content types. Show a "just created" indicator for items not yet indexed. | Integration | |

---

## 10. File Uploads & Media

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| FILE-01 | Malicious file uploaded | User uploads executable, script, or virus disguised as image/document | Critical | Medium | Validate file type by content (magic bytes), not just extension. Scan with antivirus. Serve user-uploaded files from a separate domain (prevent same-origin attacks). Set `Content-Disposition: attachment` for downloads. | Integration | |
| FILE-02 | Upload interrupted midway | Network drops during large file upload | Medium | High | Support resumable uploads (tus protocol or multipart). Show progress indicator. Allow retry without re-uploading completed chunks. Clean up incomplete uploads after 24 hours. | E2E | |
| FILE-03 | Storage quota exceeded | User or organization exceeds their storage allocation | Medium | Medium | Check quota before accepting upload. Return clear message with current usage and limit. Suggest upgrading plan or deleting old files. Never silently fail. | Unit | |
| FILE-04 | Image with EXIF GPS data | User uploads photo with embedded location metadata | Medium | Low | Strip EXIF data on upload (or make it configurable). Preserve non-sensitive metadata (dimensions, camera model) if useful. Document the behavior. | Unit | |
| FILE-05 | Concurrent uploads to same destination | Two users upload different files to the same logical location simultaneously | Medium | Low | Use unique identifiers (UUID) for storage paths, not user-defined names. If replacing, use versioning or last-write-wins with notification. | Integration | |

---

## 11. Domain-Specific Edge Cases

<!-- Add your product-specific edge cases here using the template format -->

| # | Scenario | Trigger | Impact | Likelihood | Mitigation | Test Type | Status |
|---|----------|---------|--------|-----------|------------|-----------|--------|
| DOM-01 | [Your domain-specific edge case] | [Trigger] | [Impact] | [Likelihood] | [Mitigation] | [Test Type] | |
| DOM-02 | [Your domain-specific edge case] | [Trigger] | [Impact] | [Likelihood] | [Mitigation] | [Test Type] | |

---

## Summary Statistics

| Category | Total Scenarios | Critical | High | Medium | Low | Covered | Gaps |
|----------|----------------|----------|------|--------|-----|---------|------|
| Authentication | 10 | 1 | 4 | 4 | 1 | [n] | [n] |
| Payments | 12 | 5 | 4 | 2 | 1 | [n] | [n] |
| Data Integrity | 10 | 2 | 4 | 3 | 1 | [n] | [n] |
| Concurrency | 6 | 1 | 2 | 2 | 1 | [n] | [n] |
| Timezone | 7 | 0 | 2 | 4 | 1 | [n] | [n] |
| Permissions | 8 | 4 | 1 | 2 | 1 | [n] | [n] |
| Network | 6 | 1 | 2 | 2 | 1 | [n] | [n] |
| Email | 5 | 0 | 2 | 2 | 1 | [n] | [n] |
| Search | 5 | 1 | 0 | 3 | 1 | [n] | [n] |
| File Uploads | 5 | 1 | 1 | 3 | 0 | [n] | [n] |
| **Total** | **74** | **16** | **22** | **27** | **9** | **[n]** | **[n]** |

---

## Appendix

### Related Documents
- [PRD-TEMPLATE.md](./PRD-TEMPLATE.md) -- Section 7 references this document
- [PRD-IMPLEMENTATION-AUDIT.md](./PRD-IMPLEMENTATION-AUDIT.md) -- Test Status column tracks coverage of these scenarios

### Changelog
| Date | Author | Change |
|------|--------|--------|
| [Date] | [Name] | [Initial creation / update description] |
