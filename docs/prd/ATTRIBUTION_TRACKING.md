# Attribution Tracking

> **Purpose**: Define the strategy and taxonomy for tracking how users discover, evaluate, and convert within the product. This document covers UTM parameters, referral tracking, conversion funnels, multi-touch attribution models, and the analytics event taxonomy that ties them together.
>
> **Last Updated**: [Date]
> **Owner**: [Growth / Marketing Lead]

---

## 1. UTM Parameter Strategy

### Standard UTM Parameters
All inbound marketing links must include UTM parameters. These are captured on first visit and stored through sign-up.

| Parameter | Purpose | Convention | Examples |
|-----------|---------|-----------|----------|
| `utm_source` | Where the traffic comes from | Lowercase, no spaces, use hyphens | `google`, `twitter`, `partner-acme`, `newsletter` |
| `utm_medium` | The marketing channel type | Use a controlled vocabulary (see below) | `cpc`, `organic`, `email`, `referral`, `social` |
| `utm_campaign` | The specific campaign name | `YYYY-MM-campaign-name` format | `2025-03-spring-launch`, `2025-06-webinar-series` |
| `utm_term` | Paid search keyword (optional) | The actual keyword or keyword group | `project-management-tool`, `saas-platform` |
| `utm_content` | Differentiates ad variants (optional) | Descriptive slug | `hero-cta`, `sidebar-banner`, `footer-link` |

### Controlled Vocabulary for `utm_medium`
| Value | When to Use |
|-------|-------------|
| `cpc` | Paid search (Google Ads, Bing Ads) |
| `cpm` | Display/banner advertising |
| `social-paid` | Paid social media campaigns |
| `social-organic` | Organic social media posts |
| `email` | Email campaigns and newsletters |
| `referral` | Partner referrals and backlinks |
| `affiliate` | Affiliate program links |
| `organic` | Organic search (typically not tagged; inferred) |
| `direct` | Direct traffic (typically not tagged; inferred) |
| `product` | In-product sharing, invite links |
| `event` | Conference, webinar, meetup |
| `pr` | Press/media coverage |
| `community` | Forum posts, community sites, Slack/Discord |

### UTM Capture & Storage

**Client-Side Capture**:
```
On page load:
1. Parse URL for utm_* parameters
2. Parse URL for ref, via, or custom referral parameters
3. Store in first-party cookie (180-day expiry) AND sessionStorage
4. On sign-up form submission, attach UTM data to the registration payload
```

**Server-Side Storage**:
| Field | Table | Type | Notes |
|-------|-------|------|-------|
| `utm_source` | `user_attributions` | `varchar(255)` | First-touch value |
| `utm_medium` | `user_attributions` | `varchar(255)` | First-touch value |
| `utm_campaign` | `user_attributions` | `varchar(255)` | First-touch value |
| `utm_term` | `user_attributions` | `varchar(255)`, nullable | First-touch value |
| `utm_content` | `user_attributions` | `varchar(255)`, nullable | First-touch value |
| `referrer_url` | `user_attributions` | `text`, nullable | `document.referrer` at first visit |
| `landing_page` | `user_attributions` | `text` | First page URL (without query params) |
| `first_touch_at` | `user_attributions` | `timestamp` | When the user first visited |
| `last_touch_source` | `user_attributions` | `varchar(255)`, nullable | Updated on each visit with UTM params |
| `last_touch_medium` | `user_attributions` | `varchar(255)`, nullable | Updated on each visit with UTM params |
| `last_touch_campaign` | `user_attributions` | `varchar(255)`, nullable | Updated on each visit with UTM params |
| `last_touch_at` | `user_attributions` | `timestamp`, nullable | Updated on each visit with UTM params |

**Multi-Touch Log** (for full attribution path):
| Field | Table | Type | Notes |
|-------|-------|------|-------|
| `id` | `attribution_touches` | `UUID`, PK | |
| `anonymous_id` | `attribution_touches` | `varchar(255)` | Pre-sign-up anonymous visitor ID |
| `user_id` | `attribution_touches` | `FK`, nullable | Populated after sign-up |
| `utm_source` | `attribution_touches` | `varchar(255)` | |
| `utm_medium` | `attribution_touches` | `varchar(255)` | |
| `utm_campaign` | `attribution_touches` | `varchar(255)`, nullable | |
| `referrer_url` | `attribution_touches` | `text`, nullable | |
| `page_url` | `attribution_touches` | `text` | |
| `touched_at` | `attribution_touches` | `timestamp` | |

---

## 2. Referral Tracking

### Referral Program Architecture

| Component | Detail |
|-----------|--------|
| **Referral Code** | Unique per user, format: `REF-[short-hash]` (e.g., `REF-a3k9x2`) |
| **Referral Link** | `https://[domain]/r/[code]` or `https://[domain]/?ref=[code]` |
| **Attribution Window** | 30 days from click (cookie-based) |
| **Reward Trigger** | Referee completes [defined conversion event -- e.g., first payment] |
| **Referrer Reward** | [Define: account credit, extended trial, cash, etc.] |
| **Referee Reward** | [Define: discount, extended trial, bonus features, etc.] |
| **Double-Sided** | Yes / No |
| **Max Referrals** | [Limit per referrer, or unlimited] |
| **Fraud Prevention** | Same IP check, email domain check, minimum account age to refer |

### Referral Data Model

| Field | Table | Type | Notes |
|-------|-------|------|-------|
| `id` | `referrals` | `UUID`, PK | |
| `referrer_user_id` | `referrals` | `FK to users` | The user who referred |
| `referee_user_id` | `referrals` | `FK to users`, nullable | Populated on sign-up |
| `referral_code` | `referrals` | `varchar(50)`, unique | The code used |
| `clicked_at` | `referrals` | `timestamp` | When the referral link was clicked |
| `signed_up_at` | `referrals` | `timestamp`, nullable | When the referee signed up |
| `converted_at` | `referrals` | `timestamp`, nullable | When the referee hit the conversion event |
| `referrer_rewarded_at` | `referrals` | `timestamp`, nullable | When the referrer reward was issued |
| `referee_rewarded_at` | `referrals` | `timestamp`, nullable | When the referee reward was issued |
| `status` | `referrals` | `enum` | `clicked`, `signed_up`, `converted`, `rewarded`, `expired`, `fraudulent` |
| `ip_address` | `referrals` | `inet`, nullable | For fraud detection |

### Referral Funnel Metrics
| Stage | Metric | Target |
|-------|--------|--------|
| Share | % of users who share their referral link | [Target]% |
| Click | Clicks per share | [Target] |
| Sign-up | % of clicks that result in sign-up | [Target]% |
| Conversion | % of referred sign-ups that convert to paid | [Target]% |
| Viral coefficient | (shares * click-through * sign-up * conversion) | > 1.0 for viral growth |

---

## 3. Conversion Funnel Definition

### Primary Conversion Funnel

```
Stage 1: VISITOR
  |  Anonymous visit to marketing site or app
  |  Events: page_viewed, cta_clicked
  |
  v  [Conversion Rate: ___%]
Stage 2: SIGN-UP
  |  Account created (email or OAuth)
  |  Events: sign_up_started, sign_up_completed
  |
  v  [Activation Rate: ___%]
Stage 3: ACTIVATED
  |  User completes core activation event (defined below)
  |  Events: onboarding_completed, first_core_action
  |
  v  [Trial Conversion Rate: ___%]
Stage 4: TRIAL / EVALUATION
  |  User is actively using the product during trial period
  |  Events: feature_used, session_started (recurring)
  |
  v  [Payment Conversion Rate: ___%]
Stage 5: PAYING CUSTOMER
  |  First successful payment
  |  Events: subscription_created, payment_succeeded
  |
  v  [Expansion Rate: ___%]
Stage 6: EXPANDED
  |  Upgraded plan, added seats, purchased add-ons
  |  Events: plan_upgraded, seat_added, addon_purchased
  |
  v  [Advocacy Rate: ___%]
Stage 7: ADVOCATE
  |  Refers others, leaves reviews, case study participation
  |  Events: referral_shared, review_submitted
```

### Activation Definition
<!-- This is the most important metric. Define it precisely. -->

**Activation Event**: [User performs {specific action} within {timeframe} of sign-up]

Example: "User creates at least 1 [core object] AND invites at least 1 team member within 7 days of sign-up."

| Candidate Activation Events | Correlation with 30-day Retention | Selected? |
|-----------------------------|----------------------------------|-----------|
| [Event A -- e.g., creates first project] | [r = 0.XX] | [Yes/No] |
| [Event B -- e.g., invites first team member] | [r = 0.XX] | [Yes/No] |
| [Event C -- e.g., completes first workflow] | [r = 0.XX] | [Yes/No] |
| [Combined: A + B within 7 days] | [r = 0.XX] | [Yes/No] |

### Micro-Conversion Points
| Micro-Conversion | Between Stages | Event Name | Notes |
|-----------------|----------------|------------|-------|
| CTA click on marketing site | Visitor > Sign-up | `marketing_cta_clicked` | Track which CTA |
| Email verified | Sign-up > Activated | `email_verified` | Critical for some flows |
| Onboarding step completed | Sign-up > Activated | `onboarding_step_completed` | Track step number |
| Feature discovery | Activated > Trial | `feature_discovered` | Track which feature |
| Pricing page viewed | Trial > Paying | `pricing_page_viewed` | High-intent signal |
| Checkout started | Trial > Paying | `checkout_started` | Track abandonment |
| Plan comparison viewed | Trial > Paying | `plan_comparison_viewed` | |

---

## 4. Multi-Touch Attribution Models

### Supported Models

Choose one or more models based on your business needs. Most teams start with First-Touch and Last-Touch, then graduate to a weighted model as data volume increases.

#### First-Touch Attribution
| Attribute | Detail |
|-----------|--------|
| **How it works** | 100% credit to the first touchpoint |
| **Best for** | Understanding which channels drive awareness / top-of-funnel |
| **Weakness** | Ignores all nurturing and decision-stage interactions |
| **Implementation** | Use `first_touch_*` fields from `user_attributions` table |

#### Last-Touch Attribution
| Attribute | Detail |
|-----------|--------|
| **How it works** | 100% credit to the last touchpoint before conversion |
| **Best for** | Understanding which channels close / drive final conversion |
| **Weakness** | Ignores all awareness and consideration-stage interactions |
| **Implementation** | Use `last_touch_*` fields from `user_attributions` table |

#### Linear Attribution
| Attribute | Detail |
|-----------|--------|
| **How it works** | Equal credit to every touchpoint in the journey |
| **Best for** | Balanced view when you have no reason to weight one stage over another |
| **Weakness** | Over-credits low-value touchpoints; under-credits high-impact ones |
| **Implementation** | Query `attribution_touches` table; divide credit equally among touches |

#### Time-Decay Attribution
| Attribute | Detail |
|-----------|--------|
| **How it works** | More credit to touchpoints closer to conversion; exponential decay |
| **Best for** | B2B with long sales cycles; reflects recency of influence |
| **Weakness** | Undervalues early awareness-stage interactions that started the journey |
| **Implementation** | Weight = e^(-lambda * days_before_conversion). Recommended lambda: 0.05-0.1 |

#### U-Shaped (Position-Based) Attribution
| Attribute | Detail |
|-----------|--------|
| **How it works** | 40% to first touch, 40% to last touch, 20% distributed among middle touches |
| **Best for** | Balancing awareness and closing while acknowledging nurturing |
| **Weakness** | Arbitrary weight distribution; may not reflect actual influence |
| **Implementation** | Query `attribution_touches`; apply position-based weighting formula |

#### Custom / Data-Driven Attribution
| Attribute | Detail |
|-----------|--------|
| **How it works** | ML model determines weights based on actual conversion data |
| **Best for** | High-volume businesses with enough data to train a model |
| **Weakness** | Requires significant data volume; black box; hard to explain to stakeholders |
| **Implementation** | Train logistic regression or Markov chain model on historical conversion paths |

### Attribution Model Comparison Template
| Channel | First-Touch Credit | Last-Touch Credit | Linear Credit | Time-Decay Credit | U-Shaped Credit |
|---------|-------------------|-------------------|---------------|-------------------|-----------------|
| [Channel 1] | [%] | [%] | [%] | [%] | [%] |
| [Channel 2] | [%] | [%] | [%] | [%] | [%] |
| [Channel 3] | [%] | [%] | [%] | [%] | [%] |

---

## 5. Analytics Event Taxonomy

### Event Naming Convention
```
[object]_[action]

- object: The noun (what the user is interacting with) -- lowercase, singular
- action: The verb (what happened) -- past tense, lowercase
- Use underscores to separate words within object or action

Examples:
  page_viewed
  sign_up_completed
  project_created
  subscription_upgraded
  referral_shared
```

### Reserved Properties (included with every event)
| Property | Type | Description |
|----------|------|-------------|
| `event_id` | `UUID` | Unique event identifier for deduplication |
| `event_name` | `string` | The event name (from taxonomy below) |
| `timestamp` | `ISO 8601` | When the event occurred |
| `user_id` | `UUID`, nullable | Authenticated user ID; null for anonymous events |
| `anonymous_id` | `string` | Anonymous visitor ID (persists across sessions pre-sign-up) |
| `session_id` | `UUID` | Current session identifier |
| `device_type` | `string` | `desktop`, `mobile`, `tablet` |
| `browser` | `string` | Browser name and version |
| `os` | `string` | Operating system |
| `screen_resolution` | `string` | e.g., `1920x1080` |
| `page_url` | `string` | Current page URL (without query params) |
| `referrer_url` | `string`, nullable | HTTP referrer |
| `utm_source` | `string`, nullable | UTM source if present |
| `utm_medium` | `string`, nullable | UTM medium if present |
| `utm_campaign` | `string`, nullable | UTM campaign if present |
| `app_version` | `string` | Application version |
| `environment` | `string` | `production`, `staging`, `development` |

### Core Event Taxonomy

#### Visitor & Marketing Events
| Event Name | Trigger | Key Properties | Category |
|-----------|---------|---------------|----------|
| `page_viewed` | Any page load | `page_title`, `page_path`, `page_category` | Engagement |
| `cta_clicked` | User clicks a call-to-action | `cta_id`, `cta_text`, `cta_location`, `destination_url` | Conversion |
| `marketing_form_submitted` | Lead capture form submission | `form_id`, `form_name` | Conversion |
| `pricing_page_viewed` | Pricing page load | `plan_displayed`, `billing_period` | Intent |
| `plan_comparison_viewed` | User views plan comparison | `plans_compared` | Intent |

#### Authentication Events
| Event Name | Trigger | Key Properties | Category |
|-----------|---------|---------------|----------|
| `sign_up_started` | User begins sign-up flow | `method` (`email`, `google`, `github`) | Conversion |
| `sign_up_completed` | Account successfully created | `method`, `referral_code`, `utm_*` | Conversion |
| `sign_up_abandoned` | User leaves sign-up without completing | `step_abandoned`, `method` | Conversion |
| `login_succeeded` | Successful login | `method` | Auth |
| `login_failed` | Failed login attempt | `method`, `failure_reason` | Auth |
| `password_reset_requested` | User requests password reset | -- | Auth |
| `password_reset_completed` | User completes password reset | -- | Auth |
| `session_started` | New session begins | `is_returning_user` | Engagement |
| `session_ended` | Session ends (timeout or explicit logout) | `session_duration_seconds` | Engagement |

#### Onboarding Events
| Event Name | Trigger | Key Properties | Category |
|-----------|---------|---------------|----------|
| `onboarding_started` | User enters onboarding flow | `flow_variant` | Activation |
| `onboarding_step_completed` | User completes an onboarding step | `step_number`, `step_name`, `duration_seconds` | Activation |
| `onboarding_step_skipped` | User skips an onboarding step | `step_number`, `step_name` | Activation |
| `onboarding_completed` | User finishes all onboarding steps | `total_duration_seconds`, `steps_skipped` | Activation |
| `onboarding_abandoned` | User leaves onboarding without completing | `last_step_completed`, `total_duration_seconds` | Activation |

#### Core Product Events
| Event Name | Trigger | Key Properties | Category |
|-----------|---------|---------------|----------|
| `[object]_created` | User creates a core object | `object_id`, `object_type`, `creation_method` | Engagement |
| `[object]_updated` | User modifies a core object | `object_id`, `object_type`, `fields_changed` | Engagement |
| `[object]_deleted` | User deletes a core object | `object_id`, `object_type` | Engagement |
| `[object]_viewed` | User views a core object | `object_id`, `object_type`, `view_duration_seconds` | Engagement |
| `feature_discovered` | User uses a feature for the first time | `feature_name` | Activation |
| `search_performed` | User searches | `query_length`, `results_count`, `result_clicked` | Engagement |
| `export_requested` | User exports data | `export_format`, `record_count` | Engagement |
| `import_completed` | User imports data | `import_format`, `record_count`, `errors_count` | Engagement |

#### Collaboration Events
| Event Name | Trigger | Key Properties | Category |
|-----------|---------|---------------|----------|
| `team_member_invited` | User invites someone to their organization | `invite_method` (`email`, `link`), `role` | Growth |
| `team_member_joined` | Invited user accepts and joins | `invite_source` | Growth |
| `team_member_removed` | User is removed from organization | `removed_by_role` | Admin |
| `share_link_created` | User creates a shareable link | `object_type`, `permission_level` | Growth |
| `share_link_accessed` | Someone accesses a shared link | `object_type`, `viewer_is_authenticated` | Growth |

#### Billing Events
| Event Name | Trigger | Key Properties | Category |
|-----------|---------|---------------|----------|
| `checkout_started` | User begins checkout flow | `plan_id`, `billing_period`, `trial_active` | Revenue |
| `checkout_completed` | User completes payment | `plan_id`, `billing_period`, `amount`, `currency`, `coupon_code` | Revenue |
| `checkout_abandoned` | User leaves checkout without paying | `plan_id`, `step_abandoned` | Revenue |
| `subscription_created` | New subscription started | `plan_id`, `billing_period`, `is_trial`, `trial_days` | Revenue |
| `subscription_upgraded` | User upgrades plan | `from_plan`, `to_plan`, `revenue_delta` | Revenue |
| `subscription_downgraded` | User downgrades plan | `from_plan`, `to_plan`, `revenue_delta` | Revenue |
| `subscription_cancelled` | User cancels subscription | `plan_id`, `cancellation_reason`, `feedback` | Revenue |
| `subscription_renewed` | Subscription auto-renews | `plan_id`, `amount` | Revenue |
| `payment_failed` | Payment attempt fails | `plan_id`, `failure_reason`, `retry_number` | Revenue |
| `trial_started` | Free trial begins | `plan_id`, `trial_days` | Revenue |
| `trial_ended` | Free trial expires | `plan_id`, `converted` | Revenue |

#### Referral Events
| Event Name | Trigger | Key Properties | Category |
|-----------|---------|---------------|----------|
| `referral_link_copied` | User copies their referral link | `referral_code`, `copy_location` | Growth |
| `referral_shared` | User shares referral via built-in sharing | `referral_code`, `share_method` (`email`, `twitter`, `link`) | Growth |
| `referral_link_clicked` | Someone clicks a referral link | `referral_code`, `referrer_user_id` | Growth |
| `referral_sign_up` | Referred user signs up | `referral_code`, `referrer_user_id` | Growth |
| `referral_converted` | Referred user converts to paid | `referral_code`, `referrer_user_id` | Growth |
| `referral_reward_issued` | Reward given to referrer or referee | `referral_code`, `reward_type`, `reward_value`, `recipient` | Growth |

---

## 6. Tracking Plan Template

Use this template to document every event in a structured, auditable format.

### Tracking Plan

| # | Event Name | Category | Trigger Description | Platform | Key Properties | Owner | Implemented | Verified |
|---|-----------|----------|-------------------|----------|---------------|-------|-------------|----------|
| 1 | `page_viewed` | Engagement | Any page load | Web | `page_title`, `page_path` | [Name] | [Yes/No] | [Yes/No] |
| 2 | `sign_up_completed` | Conversion | Account creation success | Web, API | `method`, `referral_code` | [Name] | [Yes/No] | [Yes/No] |
| 3 | `onboarding_completed` | Activation | All onboarding steps done | Web | `total_duration_seconds` | [Name] | [Yes/No] | [Yes/No] |
| 4 | `[object]_created` | Engagement | Core object created | Web, API | `object_id`, `object_type` | [Name] | [Yes/No] | [Yes/No] |
| 5 | `checkout_completed` | Revenue | Payment succeeded | Web | `plan_id`, `amount` | [Name] | [Yes/No] | [Yes/No] |
| ... | ... | ... | ... | ... | ... | ... | ... | ... |

### Tracking Plan Validation Checklist
- [ ] Every event has a unique, descriptive name following the naming convention
- [ ] Every event has an identified trigger (when exactly does it fire?)
- [ ] Every event has defined properties with types
- [ ] Every event has an owner responsible for implementation
- [ ] No PII is sent as an event property (email, name, phone) unless required and documented
- [ ] Events are tested in staging before production deployment
- [ ] QA has verified events fire correctly with expected properties
- [ ] Analytics dashboards / reports are updated to use new events
- [ ] Documentation is updated when events are added, modified, or deprecated

---

## 7. Implementation Guidelines

### Analytics Architecture
```
[Browser / Client]
    |
    |-- Client-side SDK (e.g., Segment, Amplitude, Mixpanel, PostHog)
    |     |-- Captures: page views, UI interactions, client-side events
    |     |-- Sends to: Analytics service + Data warehouse
    |
[API Server]
    |
    |-- Server-side SDK
    |     |-- Captures: API events, payment events, system events
    |     |-- Sends to: Analytics service + Data warehouse
    |
[Data Warehouse]
    |
    |-- Attribution modeling (SQL / dbt models)
    |-- Funnel analysis
    |-- Cohort analysis
    |-- Reporting dashboards
```

### Privacy & Compliance
- [ ] All tracking respects user cookie consent preferences (GDPR, CCPA)
- [ ] Analytics SDK is loaded conditionally based on consent
- [ ] Users can opt out of tracking; opt-out is persisted and honored
- [ ] No PII (name, email, phone, IP in identifiable form) is stored in analytics unless user consents
- [ ] Anonymous IDs are used for pre-sign-up tracking; linked to user ID on sign-up (with consent)
- [ ] Data retention policies are defined and enforced (e.g., raw events retained for 13 months)
- [ ] Data processing agreements (DPAs) are in place with all analytics providers
- [ ] Cookie banner / consent management is implemented

### Testing & QA
| Test Type | What to Verify | Tool |
|-----------|---------------|------|
| Unit | Event payload construction, property formatting | Jest / Vitest |
| Integration | Events fire on correct triggers with correct data | Cypress / Playwright |
| Manual | Check events in analytics tool's live debugger | Analytics tool debugger |
| Regression | Existing events still fire after code changes | CI pipeline |
| Volume | Events are not duplicated; are not missing | Compare server logs to analytics tool counts |

---

## Appendix

### Related Documents
- [PRD-TEMPLATE.md](./PRD-TEMPLATE.md) -- PRD template references attribution in Goals & Success Metrics
- [EDGE_CASES.md](./EDGE_CASES.md) -- Network and data edge cases affecting analytics
- [platform-overview.md](./platform-overview.md) -- Revenue model and growth strategy depend on this tracking

### Changelog
| Date | Author | Change |
|------|--------|--------|
| [Date] | [Name] | [Initial creation / update description] |
