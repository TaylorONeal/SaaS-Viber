# iOS Readiness Template

## Purpose
Use this template for repos that may become real iOS/mobile products.

This file should be copied and tailored per repo.
It should stand on its own and reflect that repo’s actual stack and product reality.

---

## 1. Product Scope for iOS
- Why should this exist on iPhone?
- What are the top 2–3 phone-first workflows?
- What should be cut from v1 mobile?

---

## 2. Current Mobile Stack
- Actual stack:
- Build tools:
- Deploy/signing path:

Do not assume a stack. Document the real one.

---

## 3. Config Readiness
- App config resolves correctly
- Bundle ID / scheme / app naming are correct
- Required native plugins/modules are installed
- No stale config files override runtime unexpectedly

---

## 4. Dependency Readiness
- Fresh install works
- Lockfile is present and trusted
- Mobile/native peer dependencies are compatible
- CI install path is deterministic

---

## 5. Native Capability Requirements
List only real capabilities required by the app, such as:
- Sign in with Apple
- secure storage
- subscriptions / purchases
- notifications
- camera/mic
- deep links

---

## 6. Test Environment Readiness
- How will auth be tested?
- What seeded users/data are needed?
- What environment is real enough to validate the app?
- How is demo/test/prod separated?

---

## 7. UX / Native Quality
- Does the app feel native enough?
- Are navigation, forms, loading states, and small-screen layouts coherent?
- Does the app justify being native/mobile?

---

## 8. Build / Signing Path
Document one canonical path:
- local/native generation path
- CI path
- signing path
- fallback/manual debug path

---

## 9. Launch / Review Readiness
Before release:
- build path is deterministic
- capabilities are coherent
- product is not visibly half-finished
- review-sensitive behavior is correct
- metadata/screenshots are gatherable

---

## 10. Current Focus
List the few most important mobile-readiness tasks for this repo right now.
