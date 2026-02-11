# Tracking Plan

> The single source of truth for every analytics event in your app.
> Update this file whenever you add, modify, or remove an event.

---

## How to Use This File

1. Before implementing a feature, check if new events are needed
2. Add new events to this plan BEFORE writing code
3. Follow the naming convention: `object_action` (lowercase, underscores)
4. Implement using `trackEvent()` from `src/lib/analytics.ts`
5. Mark events as implemented after verifying in PostHog/GA4

---

## Event Naming Convention

**Format:** `object_action`

```
Good:                          Bad:
signup_completed               SignupCompleted (no camelCase)
pricing_plan_selected          click_button (too vague)
feature_used                   user-did-thing (no hyphens)
payment_completed              trackPurchase (no verb prefix)
```

**Rules:**
- All lowercase
- Underscores between words
- Object first, then action
- Be specific enough to be useful, general enough to be queryable
- Context goes in properties, not event name

---

## Event Registry

### Authentication Events

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `signup_started` | User lands on signup page | `method` (email, google, github), `referrer` | P0 | [ ] |
| `signup_completed` | Registration successful | `method`, `plan`, `utm_source`, `utm_medium`, `utm_campaign` | P0 | [ ] |
| `login_completed` | Sign-in successful | `method` | P0 | [ ] |
| `login_failed` | Sign-in failed | `method`, `error_type` | P1 | [ ] |
| `logout_completed` | User signs out | — | P1 | [ ] |
| `password_reset_requested` | User requests reset | — | P1 | [ ] |
| `password_reset_completed` | User resets password | — | P1 | [ ] |
| `email_verified` | User verifies email | `time_to_verify_hours` | P1 | [ ] |

### Onboarding Events

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `onboarding_started` | Welcome screen shown | `user_type` (new, invited) | P0 | [ ] |
| `onboarding_step_completed` | User completes a step | `step_number`, `step_name`, `duration_seconds` | P0 | [ ] |
| `onboarding_step_skipped` | User skips a step | `step_number`, `step_name` | P1 | [ ] |
| `onboarding_completed` | All steps done | `total_duration_seconds`, `steps_skipped` | P0 | [ ] |
| `onboarding_dismissed` | User exits early | `last_step_completed` | P1 | [ ] |

### Core Product Events

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `core_entity_created` | User creates primary entity | `entity_type` | P0 | [ ] |
| `core_entity_updated` | User edits entity | `entity_type`, `fields_changed` | P1 | [ ] |
| `core_entity_deleted` | User deletes entity | `entity_type` | P1 | [ ] |
| `core_entity_viewed` | User views entity detail | `entity_type`, `entity_id` | P2 | [ ] |
| `core_action_completed` | User does the main thing | `action_type` | P0 | [ ] |
| `search_performed` | User searches | `query_length`, `results_count`, `has_filters` | P1 | [ ] |
| `filter_applied` | User applies a filter | `filter_type`, `filter_value` | P2 | [ ] |
| `export_requested` | User exports data | `format` (csv, pdf, json), `row_count` | P2 | [ ] |

### Feature Usage Events

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `feature_used` | Any named feature interaction | `feature_name` | P1 | [ ] |
| `dashboard_viewed` | User views dashboard | `widgets_visible` | P1 | [ ] |
| `settings_updated` | User changes settings | `setting_category`, `setting_name` | P1 | [ ] |
| `theme_changed` | User changes theme | `theme` (light, dark, system) | P2 | [ ] |
| `keyboard_shortcut_used` | User uses keyboard shortcut | `shortcut`, `action` | P2 | [ ] |

### Team / Organization Events

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `organization_created` | User creates org | `plan` | P0 | [ ] |
| `invite_sent` | User invites team member | `invite_method` (email, link), `role` | P0 | [ ] |
| `invite_accepted` | Invitee joins | `role`, `time_to_accept_hours` | P0 | [ ] |
| `member_role_changed` | Admin changes role | `old_role`, `new_role` | P1 | [ ] |
| `member_removed` | Admin removes member | `role` | P1 | [ ] |

### Billing Events

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `pricing_viewed` | Pricing page loaded | `current_plan`, `source` (header, settings, upgrade-prompt) | P0 | [ ] |
| `checkout_started` | User clicks subscribe | `plan`, `billing_period` (monthly, annual) | P0 | [ ] |
| `payment_completed` | Payment successful | `plan`, `amount`, `currency`, `billing_period` | P0 | [ ] |
| `payment_failed` | Payment fails | `plan`, `error_type` | P0 | [ ] |
| `subscription_upgraded` | User upgrades plan | `from_plan`, `to_plan` | P0 | [ ] |
| `subscription_downgraded` | User downgrades plan | `from_plan`, `to_plan` | P0 | [ ] |
| `subscription_cancelled` | User cancels | `plan`, `reason`, `tenure_days` | P0 | [ ] |
| `subscription_reactivated` | User resubscribes | `plan` | P1 | [ ] |

### Engagement Events

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `notification_received` | Notification delivered | `notification_type`, `channel` (in-app, email) | P2 | [ ] |
| `notification_clicked` | User clicks notification | `notification_type` | P2 | [ ] |
| `feedback_submitted` | User submits feedback | `rating`, `category`, `has_text` | P1 | [ ] |
| `help_opened` | User opens help/docs | `page`, `source` | P2 | [ ] |
| `error_encountered` | User sees error state | `error_type`, `page`, `action` | P1 | [ ] |

### Marketing Events (GA4-specific)

| Event | Trigger | Properties | Priority | Status |
|---|---|---|---|---|
| `page_view` | Route change | `page_title`, `page_path` | P0 | [ ] |
| `scroll_depth` | User scrolls (landing pages) | `percent` (25, 50, 75, 100) | P2 | [ ] |
| `cta_clicked` | CTA button clicked | `button_text`, `location`, `page` | P1 | [ ] |
| `outbound_link_clicked` | External link clicked | `url`, `link_text` | P2 | [ ] |
| `video_played` | User plays a video | `video_id`, `duration` | P2 | [ ] |

---

## Implementation Checklist

### Per Event

- [ ] Event added to this tracking plan with properties documented
- [ ] Event implemented using `trackEvent()` from `src/lib/analytics.ts`
- [ ] Properties include all documented fields (no undocumented extras)
- [ ] No PII in properties (no email, name, phone, IP)
- [ ] Verified in PostHog Events tab (production or staging)
- [ ] Verified in GA4 DebugView (if GA4 event)
- [ ] No duplicate firing (check with browser console in dev)

### Per Feature

- [ ] All relevant events from this plan are instrumented
- [ ] Funnel created in PostHog for the feature's user flow
- [ ] Dashboard or insight saved in PostHog for the feature
- [ ] This tracking plan updated with implementation status

---

## Funnel Definitions

Define your key funnels here. Create matching funnels in PostHog.

### Acquisition Funnel

```
Step 1: page_view (path = /signup OR /register)
Step 2: signup_completed
Step 3: onboarding_completed
Step 4: core_action_completed
Window: 14 days
```

### Activation Funnel

```
Step 1: signup_completed
Step 2: onboarding_step_completed (step = 1)
Step 3: core_entity_created
Step 4: invite_sent (optional — B2B only)
Window: 7 days
```

### Revenue Funnel

```
Step 1: pricing_viewed
Step 2: checkout_started
Step 3: payment_completed
Window: 30 days
Breakdown by: current_plan, source
```

### Retention Definition

**Active user** = fired `core_action_completed` OR `core_entity_created` at least once in the period.

| Period | Window |
|---|---|
| Daily Active (DAU) | At least 1 qualifying event today |
| Weekly Active (WAU) | At least 1 qualifying event in last 7 days |
| Monthly Active (MAU) | At least 1 qualifying event in last 30 days |

---

## AI Prompt for Generating Events

When adding a new feature, use this prompt with your AI agent:

```
I'm adding [FEATURE NAME] to my SaaS app.

The feature allows users to [DESCRIBE WHAT IT DOES].

Based on the tracking plan in docs/developer/tracking-plan.md,
generate the analytics events I should track for this feature:

1. List each event with name (object_action format), trigger, and properties
2. Assign priority (P0 = critical path, P1 = important, P2 = nice-to-have)
3. Suggest which funnel this feature affects
4. Write the trackEvent() calls I need to add to my React components

Follow the naming convention: lowercase, underscores, object_action format.
No PII in properties.
```

---

## Related Docs

- `decisions/ANALYTICS_CHOICES.md` — Choose your analytics platform
- `docs/developer/analytics-setup.md` — PostHog + GA4 setup guide with code
- `docs/architecture/ANALYTICS_ARCHITECTURE.md` — Admin dashboard, KPIs, growth metrics
- `docs/prd/ATTRIBUTION_TRACKING.md` — UTM strategy, attribution models, event taxonomy
