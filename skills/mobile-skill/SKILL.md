---
name: mobile-cross-platform
description: Standards for shipping a product across web and native (iOS/Android) -- separating the marketing site from the app, sharing design tokens, planning App Store/Play compliance, choosing web vs in-app billing, and handling mobile viewport/safe-area realities. Load for any mobile UI, cross-platform, or app-store submission work.
---

# Mobile & Cross-Platform Skill

Decisions here are expensive to reverse. Make them deliberately and early.

## 1. Separate the Marketing Site From the App

- The landing page and the product are different deploys with different
  audiences, release cadences, and performance budgets. Keep them decoupled.
- A copy tweak to the storefront must never risk the app, and an app outage must
  never take down the storefront.
- Share brand assets and tokens between them; do not share runtime code.

## 2. Share Tokens, Not Components, Across Platforms

- Web and native look like one brand because they consume the same
  `docs/design/tokens/tokens.json` (colors, spacing, type scale) -- not because a
  component was forced to render on both.
- Tokens travel cleanly across platforms; components carry platform-specific
  baggage (DOM assumptions, gesture models, navigation paradigms).

## 3. Plan Store Compliance Before You Build

- Privacy nutrition labels (iOS) and the Data Safety form (Android) are answers
  about your architecture -- design the data flows so the answers are clean.
- "Delete my account" must be reachable in-app; build it from the start.
- Request only permissions you use, and have a clear reason string for each.
- See `docs/architecture/APP_STORE_COMPLIANCE.md`,
  `docs/guides/IOS_READINESS_CHECKLIST.md`, and
  `docs/guides/ANDROID_READINESS_CHECKLIST.md`.

## 4. Decide Web vs In-App Billing Early

- Web checkout (Stripe) and in-app purchase (StoreKit / Play Billing, often via
  RevenueCat) have different fees, rules, and entitlement plumbing.
- The stores take their cut and restrict steering users to external payment from
  inside the app. Know the current rules for your category before you commit.
- Pick the model before writing entitlement logic; it shapes the whole billing
  layer and your margins. See `docs/architecture/BILLING_MODELS.md`.

## 5. Respect the Mobile Viewport and Safe Areas

- Use `min-h-[100dvh]`, never `100vh`/`h-screen`, for full-height sections --
  `vh` causes catastrophic jumping as mobile browser chrome shows/hides.
- Honor safe-area insets (notch, home indicator, dynamic toolbars) with
  `env(safe-area-inset-*)` / platform-safe-area APIs.
- Touch targets are at least 44x44pt. Test on a physical mid-tier device; the
  simulator hides clipping, jank, and real network behavior.

## Pre-Flight Check

- [ ] Marketing site and app are separately deployable.
- [ ] Cross-platform visual consistency comes from shared tokens, not shared components.
- [ ] Store compliance (privacy labels, account deletion, permissions) is designed in.
- [ ] Billing model (web vs in-app) is chosen before entitlement code.
- [ ] Full-height layouts use `100dvh`; safe areas and 44pt targets are honored.
- [ ] Verified on a real device, not just the simulator.

Underlying principles: `docs/ai-agents/LESSONS_LEARNED.md` (Mobile &
Cross-Platform). Frontend visual standards remain governed by
`skills/taste-skill/SKILL.md`.
