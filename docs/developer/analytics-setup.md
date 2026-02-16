# Analytics Setup Guide

> How to instrument your SaaS app with analytics. Covers PostHog and GA4
> integration, the analytics service abstraction, React hooks for event
> tracking, and server-side event patterns.

---

## Prerequisites

- Decisions made: read `decisions/ANALYTICS_CHOICES.md`
- Event taxonomy defined: read `docs/prd/ATTRIBUTION_TRACKING.md`
- React + TypeScript app running

---

## 1. Install Dependencies

### PostHog (recommended for product analytics)

```bash
npm install posthog-js
```

### Google Analytics 4 (recommended for web/acquisition analytics)

No npm package needed — use the gtag.js script in `index.html`, or:

```bash
npm install @analytics/google-analytics  # if using analytics abstraction
```

### Both (recommended combo)

```bash
npm install posthog-js
```

Plus the GA4 script tag in `index.html`.

---

## 2. Environment Variables

Add to `.env`:

```bash
# PostHog
VITE_POSTHOG_KEY="phc_your_project_api_key"
VITE_POSTHOG_HOST="https://app.posthog.com"   # or your self-hosted URL

# Google Analytics 4
VITE_GA_MEASUREMENT_ID="G-XXXXXXXXXX"

# Feature flags
VITE_ANALYTICS_ENABLED="true"                   # disable in test environments
```

---

## 3. Analytics Service Abstraction

Create a single analytics service that wraps all providers. Components never call PostHog or GA4 directly.

```typescript
// src/lib/analytics.ts

import posthog from "posthog-js";

// ─── Types ───────────────────────────────────────────

interface EventProperties {
  [key: string]: string | number | boolean | null | undefined;
}

interface UserTraits {
  email?: string;
  name?: string;
  plan?: string;
  role?: string;
  organization_id?: string;
  created_at?: string;
  [key: string]: string | number | boolean | null | undefined;
}

interface PageProperties {
  title?: string;
  url?: string;
  referrer?: string;
  [key: string]: string | number | boolean | null | undefined;
}

// ─── Initialization ──────────────────────────────────

let initialized = false;

export function initAnalytics(): void {
  if (initialized) return;
  if (import.meta.env.VITE_ANALYTICS_ENABLED !== "true") return;

  // PostHog
  const posthogKey = import.meta.env.VITE_POSTHOG_KEY;
  const posthogHost = import.meta.env.VITE_POSTHOG_HOST;
  if (posthogKey) {
    posthog.init(posthogKey, {
      api_host: posthogHost || "https://app.posthog.com",
      capture_pageview: false,        // We handle pageviews manually
      capture_pageleave: true,
      autocapture: false,             // Explicit events only (less noise)
      persistence: "localStorage+cookie",
      loaded: (ph) => {
        if (import.meta.env.DEV) ph.debug();
      },
    });
  }

  // GA4 is initialized via script tag in index.html
  // No additional init needed here

  initialized = true;
}

// ─── Identify ────────────────────────────────────────

export function identifyUser(userId: string, traits?: UserTraits): void {
  if (!initialized) return;

  // PostHog
  posthog.identify(userId, traits);

  // GA4
  if (window.gtag) {
    window.gtag("set", { user_id: userId });
    if (traits) {
      window.gtag("set", "user_properties", traits);
    }
  }
}

// ─── Track Event ─────────────────────────────────────

export function trackEvent(name: string, properties?: EventProperties): void {
  if (!initialized) return;

  // PostHog
  posthog.capture(name, properties);

  // GA4
  if (window.gtag) {
    window.gtag("event", name, properties);
  }

  // Development logging
  if (import.meta.env.DEV) {
    console.log(`[Analytics] ${name}`, properties);
  }
}

// ─── Page View ───────────────────────────────────────

export function trackPageView(properties?: PageProperties): void {
  if (!initialized) return;

  const pageProps = {
    title: document.title,
    url: window.location.href,
    path: window.location.pathname,
    referrer: document.referrer,
    ...properties,
  };

  // PostHog
  posthog.capture("$pageview", pageProps);

  // GA4 (handled automatically if using gtag.js config with send_page_view)
  if (window.gtag) {
    window.gtag("event", "page_view", {
      page_title: pageProps.title,
      page_location: pageProps.url,
      page_path: pageProps.path,
    });
  }
}

// ─── Reset (on logout) ──────────────────────────────

export function resetAnalytics(): void {
  if (!initialized) return;
  posthog.reset();
}

// ─── Feature Flags (PostHog) ─────────────────────────

export function isFeatureEnabled(flag: string): boolean {
  if (!initialized) return false;
  return posthog.isFeatureEnabled(flag) ?? false;
}

// ─── Group Analytics (for B2B / org-level tracking) ──

export function setGroup(groupType: string, groupId: string, traits?: Record<string, unknown>): void {
  if (!initialized) return;
  posthog.group(groupType, groupId, traits);
}
```

---

## 4. React Integration

### Analytics Provider

```typescript
// src/contexts/AnalyticsProvider.tsx

import { useEffect } from "react";
import { useLocation } from "react-router-dom";
import { initAnalytics, trackPageView } from "@/lib/analytics";

export function AnalyticsProvider({ children }: { children: React.ReactNode }) {
  const location = useLocation();

  // Initialize on mount
  useEffect(() => {
    initAnalytics();
  }, []);

  // Track page views on route change
  useEffect(() => {
    trackPageView();
  }, [location.pathname]);

  return <>{children}</>;
}
```

Mount it in your app root:

```typescript
// src/App.tsx
import { AnalyticsProvider } from "@/contexts/AnalyticsProvider";

function App() {
  return (
    <BrowserRouter>
      <AnalyticsProvider>
        <Routes>{/* your routes */}</Routes>
      </AnalyticsProvider>
    </BrowserRouter>
  );
}
```

### useTrackEvent Hook

```typescript
// src/hooks/useTrackEvent.ts

import { useCallback } from "react";
import { trackEvent } from "@/lib/analytics";

export function useTrackEvent() {
  return useCallback(
    (name: string, properties?: Record<string, unknown>) => {
      trackEvent(name, properties);
    },
    []
  );
}
```

Usage in components:

```typescript
function PricingPage() {
  const track = useTrackEvent();

  return (
    <button onClick={() => track("pricing_plan_selected", { plan: "pro", billing: "annual" })}>
      Choose Pro
    </button>
  );
}
```

---

## 5. GA4 Script Setup

Add to `index.html` before the closing `</head>` tag:

```html
<!-- Google Analytics 4 -->
<script>
  // Only load in production with a valid measurement ID
  (function() {
    var id = '%VITE_GA_MEASUREMENT_ID%';  // Vite replaces at build time
    if (!id || id.indexOf('VITE_') === 0) return;

    var s = document.createElement('script');
    s.src = 'https://www.googletagmanager.com/gtag/js?id=' + id;
    s.async = true;
    document.head.appendChild(s);

    window.dataLayer = window.dataLayer || [];
    window.gtag = function() { dataLayer.push(arguments); };
    gtag('js', new Date());
    gtag('config', id, {
      send_page_view: false,  // We handle this in AnalyticsProvider
      cookie_flags: 'SameSite=None;Secure'
    });
  })();
</script>
```

Add the TypeScript declaration:

```typescript
// src/types/gtag.d.ts
declare function gtag(...args: unknown[]): void;
interface Window {
  gtag?: typeof gtag;
  dataLayer?: unknown[];
}
```

---

## 6. Essential Events to Instrument

These events map to the taxonomy in `docs/prd/ATTRIBUTION_TRACKING.md`. Implement in this priority order:

### P0 — Instrument First

| Event | Where | Properties |
|---|---|---|
| `signup_started` | Sign-up page load | `method` (email, google, github) |
| `signup_completed` | After successful registration | `method`, `plan` |
| `login_completed` | After successful sign-in | `method` |
| `onboarding_step_completed` | Each onboarding step | `step_number`, `step_name` |
| `onboarding_completed` | Final onboarding step | `duration_seconds` |
| `core_action_completed` | User does the main thing | `action_type`, `entity_id` |
| `pricing_viewed` | Pricing page load | `current_plan` |
| `checkout_started` | Clicks "subscribe" / "upgrade" | `plan`, `billing_period` |
| `payment_completed` | Successful payment | `plan`, `amount`, `currency` |
| `subscription_cancelled` | User cancels | `plan`, `reason`, `tenure_days` |

### P1 — Instrument Next

| Event | Where | Properties |
|---|---|---|
| `feature_used` | Any feature interaction | `feature_name` |
| `search_performed` | Search action | `query`, `results_count` |
| `invite_sent` | Team invite | `invite_method` (email, link) |
| `invite_accepted` | Invitee joins | `organization_id` |
| `settings_updated` | Settings save | `setting_category` |
| `export_requested` | Data export | `format` (csv, pdf) |
| `error_encountered` | Error boundary / API error | `error_type`, `error_message`, `page` |
| `feedback_submitted` | Feedback widget | `rating`, `category` |

### P2 — Instrument Later

| Event | Where | Properties |
|---|---|---|
| `notification_clicked` | Notification bell | `notification_type` |
| `help_opened` | Help widget / docs | `page`, `query` |
| `theme_changed` | Theme toggle | `theme` (light, dark, system) |
| `keyboard_shortcut_used` | Shortcut pressed | `shortcut_key`, `action` |

---

## 7. Server-Side Event Tracking

For events that happen on the backend (payment webhooks, subscription changes, email events):

```typescript
// Server-side: PostHog Node SDK
import { PostHog } from "posthog-node";

const posthog = new PostHog(process.env.POSTHOG_API_KEY!, {
  host: process.env.POSTHOG_HOST || "https://app.posthog.com",
});

// In your Stripe webhook handler:
posthog.capture({
  distinctId: userId,
  event: "payment_completed",
  properties: {
    plan: subscription.plan,
    amount: invoice.amount_paid / 100,
    currency: invoice.currency,
    payment_method: "stripe",
  },
});

// In your email service:
posthog.capture({
  distinctId: userId,
  event: "email_sent",
  properties: {
    template: "welcome",
    provider: "resend",
  },
});

// Flush before serverless function exits
await posthog.shutdown();
```

---

## 8. Consent and Privacy

### Cookie Consent Pattern

```typescript
// Only initialize analytics after consent
export function initAnalyticsWithConsent(hasConsent: boolean): void {
  if (!hasConsent) {
    // Initialize PostHog in cookieless mode
    posthog.init(key, {
      persistence: "memory",       // No cookies or localStorage
      autocapture: false,
      capture_pageview: false,
    });
    return;
  }

  // Full initialization with persistence
  initAnalytics();
}
```

### Plausible (No Consent Needed)

If using Plausible for web analytics alongside PostHog for product analytics:

```html
<!-- No cookies, no consent required -->
<script defer data-domain="yourdomain.com" src="https://plausible.io/js/script.js"></script>
```

---

## 9. Testing Analytics

### Development Mode

The analytics service logs all events to console in dev mode. Check the browser console for:

```
[Analytics] signup_completed { method: "email", plan: "free" }
```

### PostHog Debug Mode

Enable in development:
```typescript
posthog.debug();  // Shows all events in console
```

### Validation Checklist

- [ ] Events fire on correct user actions (check browser console)
- [ ] Properties contain expected values (no undefined)
- [ ] No duplicate events on the same action
- [ ] Page views fire on route changes (not on every render)
- [ ] User identification works after login
- [ ] Analytics reset on logout
- [ ] Events don't fire in test environments
- [ ] Server-side events appear in PostHog/GA4 with correct user ID

---

## 10. Debugging Common Issues

| Issue | Cause | Fix |
|---|---|---|
| Events not appearing in PostHog | API key wrong or host wrong | Check `.env` values, check network tab for `posthog.com` requests |
| Duplicate page views | `trackPageView` called on every render | Ensure it's in a `useEffect` with `[location.pathname]` dependency |
| User ID not set | `identifyUser` called before analytics init | Call `initAnalytics()` first, then `identifyUser()` after login |
| Events in wrong PostHog project | Using production key in development | Use separate PostHog projects for dev and prod |
| GA4 events not appearing | Measurement ID wrong or script not loaded | Check browser console for gtag errors, verify ID in `.env` |
| Server events missing user | `distinctId` not matching client-side ID | Use the same user ID format (e.g., Supabase `user.id`) on both sides |

---

## Related Docs

- `decisions/ANALYTICS_CHOICES.md` — Compare analytics platforms
- `docs/prd/ATTRIBUTION_TRACKING.md` — Event taxonomy, funnels, attribution models
- `docs/architecture/ANALYTICS_ARCHITECTURE.md` — Admin dashboard, KPIs, growth metrics
- `docs/developer/tracking-plan.md` — Event implementation checklist
