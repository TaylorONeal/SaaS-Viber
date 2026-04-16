# Testing Framework: Key Decisions

> **Prompt Guide**: Use this document to understand your mobile testing options. Pair with `docs/testing/TESTING_FRAMEWORK_GUIDE.md` for setup instructions and `docs/architecture/MOBILE_ARCHITECTURE.md` for platform context.

## Why This Matters

Mobile testing strategy directly impacts release confidence, iteration speed, and defect escape rate. Choosing the wrong framework wastes engineering time — either by over-investing in tests that break on every UI change or under-investing and shipping bugs to production. The right choice depends on your tech stack, team skills, and what you're actually trying to verify.

---

## Decision Matrix

| Factor | XCTest | Maestro | Detox | Appium | EarlGrey |
|--------|--------|---------|-------|--------|----------|
| **Platform** | iOS/macOS only | iOS + Android | iOS + Android (React Native) | iOS + Android + Web | iOS only |
| **Language** | Swift / Obj-C | YAML (no code) | JavaScript | Java / JS / Python / etc. | Swift / Obj-C |
| **Maintained by** | Apple | mobile.dev | Wix | OpenJS Foundation | Google |
| **Test types** | Unit + UI + Performance | E2E / UI flows | E2E / UI flows | E2E / UI flows | Unit + UI |
| **Setup complexity** | Low (built into Xcode) | Very low (CLI install) | Medium | High | Medium |
| **CI/CD integration** | Xcode Cloud, Fastlane | CLI-native, any CI | CLI-native, any CI | Selenium Grid, cloud providers | Xcode, Fastlane |
| **Speed** | Fast (unit), Medium (UI) | Fast | Medium | Slow | Fast |
| **Flakiness** | Low | Low | Medium | High | Low |
| **Learning curve** | Medium (Swift required) | Very low (YAML) | Medium (JS required) | High (complex setup) | Medium (Swift required) |
| **Cross-platform** | No | Yes | React Native only | Yes | No |
| **Native API access** | Full | None | Limited | Limited | Full |
| **Cost** | Free (requires Mac) | Free (open source) | Free (open source) | Free (open source) | Free (open source) |
| **Community** | Massive (Apple ecosystem) | Growing fast | Large (RN community) | Large but fragmented | Small (Google internal) |

---

## Option 1: XCTest

**What it is**: Apple's first-party testing framework, built into Xcode. Supports unit tests, UI tests, and performance tests for iOS, macOS, watchOS, and tvOS applications.

### When to Choose It

- You are building a **native iOS/macOS app** in Swift or Objective-C
- You need **unit tests** for business logic, models, and services
- You need **UI tests** that verify iOS-native interaction patterns
- You want **performance benchmarking** with Xcode baselines
- You are using **Xcode Cloud** or **Fastlane** for CI/CD
- You need **deep platform integration** (Keychain, HealthKit, CoreData, etc.)
- Your team already knows Swift

### When NOT to Choose It

- You are building a **web-only** application (React, Vue, etc.)
- You need **cross-platform** test coverage (iOS + Android from one codebase)
- You are using **React Native** or **Flutter** (use their native testing tools)
- You want **non-developers** (QA, PMs) to write and maintain tests
- You are wrapping a web app in **Capacitor/Ionic** and the native layer is thin

### Tradeoffs

- **Pro**: Zero setup — comes with Xcode, no extra dependencies
- **Pro**: Best-in-class integration with iOS APIs and simulators
- **Pro**: Parallel test execution across simulators
- **Pro**: Code coverage built into Xcode
- **Pro**: Test plans support multiple configurations (languages, accessibility, dark mode)
- **Pro**: XCUITest can automate real device gestures, alerts, and system dialogs
- **Con**: iOS/macOS only — no Android coverage
- **Con**: Requires Swift/Obj-C knowledge
- **Con**: UI tests are slower than unit tests
- **Con**: UI tests can be brittle if accessibility identifiers aren't maintained
- **Con**: Requires a Mac to run

### Best For

| Stack | Fit |
|-------|-----|
| Native Swift iOS app | Perfect |
| Native Swift + Kotlin (separate codebases) | iOS side only |
| SwiftUI app | Perfect |
| Capacitor/Ionic wrapper (thick native layer) | Good for native layer |
| Capacitor/Ionic wrapper (thin native layer) | Overkill — use Maestro |
| React Native | Use Detox instead |
| Flutter | Use Flutter test + integration_test |
| Web only (React, Vue, etc.) | Not applicable |

---

## Option 2: Maestro

**What it is**: A modern mobile UI testing framework that uses simple YAML files to define test flows. Built for speed and reliability, with no code required to write tests.

### When to Choose It

- You want **cross-platform** E2E tests (iOS + Android from one flow file)
- Your team includes **non-developers** who need to write or review tests
- You want **fast test authoring** — a login test takes 5 minutes to write
- You are building with **any mobile framework** (native, React Native, Flutter, Capacitor)
- You want **low-flakiness** E2E tests (Maestro waits intelligently for elements)
- You prioritize **developer experience** and minimal config
- You need **screenshot capture** for visual regression or App Store assets

### When NOT to Choose It

- You need **unit tests** for isolated business logic — Maestro only does E2E/UI
- You need to test **native APIs** that have no UI surface (Keychain, background tasks)
- You need **performance benchmarks** with precise measurements
- You need to interact with **system dialogs** beyond basic permissions
- Your app has no UI (pure backend/API service)

### Tradeoffs

- **Pro**: YAML-based — no programming language required
- **Pro**: Cross-platform from a single flow file
- **Pro**: Built-in wait mechanism reduces flakiness
- **Pro**: Extremely fast to set up (one CLI command)
- **Pro**: Built-in screenshot capture for visual testing
- **Pro**: Runs locally and in CI with identical behavior
- **Pro**: Supports environment variables for test data management
- **Con**: E2E only — cannot replace unit tests
- **Con**: No access to native APIs or internal app state
- **Con**: Less mature ecosystem compared to XCTest or Appium
- **Con**: Complex gesture sequences can be hard to express in YAML
- **Con**: No performance profiling capability

### Best For

| Stack | Fit |
|-------|-----|
| React Native app | Excellent |
| Flutter app | Excellent |
| Capacitor/Ionic wrapper | Excellent |
| Native Swift iOS app | Good (for E2E only; pair with XCTest for units) |
| Native Kotlin Android app | Good (for E2E only; pair with JUnit for units) |
| PWA in mobile browser | Limited (Maestro targets native apps) |
| Web only (React, Vue, etc.) | Not applicable (use Playwright/Cypress) |

---

## Recommended Combinations by Stack

The right answer is often **both frameworks** used for different purposes. Here's the recommendation for each common SaaS-Viber deployment target:

### Web Only (React + Vite)

Neither XCTest nor Maestro applies. Use:
- **Vitest** for unit/integration tests
- **Playwright** or **Cypress** for E2E browser tests

### Capacitor / Ionic Wrapper

| Layer | Framework | Why |
|-------|-----------|-----|
| Web logic (React components, hooks, utils) | Vitest | Fast, runs in Node |
| Native shell + plugins | XCTest (iOS) | Test native bridge, permissions, deep links |
| Full user flows | **Maestro** | Cross-platform E2E, easy to write |

### React Native

| Layer | Framework | Why |
|-------|-----------|-----|
| Business logic, hooks | Jest + React Native Testing Library | Standard RN testing |
| Component rendering | React Native Testing Library | Component-level tests |
| Full user flows | **Maestro** or **Detox** | E2E across both platforms |

### Native Swift iOS

| Layer | Framework | Why |
|-------|-----------|-----|
| Models, services, view models | **XCTest** (unit) | Fast, deep API access |
| UI interaction | **XCTest** (XCUITest) | Native, reliable |
| Cross-device smoke tests | **Maestro** | Quick flow verification |
| Performance | **XCTest** (measure blocks) | Xcode baselines |

### Native Swift + Kotlin (Separate Codebases)

| Layer | Framework | Why |
|-------|-----------|-----|
| iOS unit tests | **XCTest** | Native iOS testing |
| Android unit tests | JUnit / Espresso | Native Android testing |
| Cross-platform E2E | **Maestro** | Single flow, both platforms |

### Flutter

| Layer | Framework | Why |
|-------|-----------|-----|
| Widget tests | Flutter test | Built-in framework |
| Integration tests | integration_test | Built-in framework |
| Cross-platform E2E | **Maestro** | Complements Flutter's test tools |

---

## Decision Template

Copy and fill in for your project:

```markdown
### Testing Framework Decision

**Date**: [DATE]
**Decided by**: [NAME/TEAM]

**Mobile Strategy**: [Native iOS / React Native / Flutter / Capacitor / PWA / Web Only]

**Chosen Frameworks**:
- Unit tests: [XCTest / Jest / Vitest / JUnit / Flutter test]
- E2E tests: [Maestro / Detox / XCUITest / Appium]

**Rationale**: [Why these choices fit your team, stack, and timeline]

**Trade-offs Accepted**: [What you're giving up]

**Review Date**: [When to revisit this decision — suggest 6 months]
```

---

*Both XCTest and Maestro are set up in `tests/xctest/` and `tests/maestro/`. See `docs/testing/TESTING_FRAMEWORK_GUIDE.md` for setup instructions.*
