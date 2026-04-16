# Maestro Setup Guide — [YOUR_APP_NAME]

> **Purpose:** Step-by-step instructions for installing Maestro and running
> the included test flows against your mobile application.
>
> **Prerequisites:**
> - macOS or Linux
> - A built mobile app (iOS simulator build or Android APK/AAB)
> - A running simulator/emulator or connected device

---

## Quick Start

### 1. Install Maestro

```bash
# macOS / Linux
curl -Ls "https://get.maestro.mobile.dev" | bash

# Verify installation
maestro --version

# The CLI is installed to ~/.maestro/bin/
# Add to PATH if not already:
export PATH="$PATH:$HOME/.maestro/bin"
```

### 2. Start a Simulator

```bash
# iOS: Boot a simulator
xcrun simctl boot "iPhone 15"

# Android: Start an emulator
emulator -avd Pixel_7_API_34

# Or connect a physical device via USB (Android: enable USB debugging)
```

### 3. Install Your App

```bash
# iOS Simulator
xcrun simctl install booted /path/to/YourApp.app

# Android
adb install /path/to/your-app.apk
```

### 4. Run Tests

```bash
# Run all flows
maestro test tests/maestro/flows/

# Run a single flow
maestro test tests/maestro/flows/login.yaml

# Run smoke tests only
maestro test --include-tags=smoke tests/maestro/flows/

# Run with custom env vars
maestro test -e EMAIL=custom@test.com tests/maestro/flows/login.yaml
```

---

## Project Structure

```
tests/maestro/
├── config.yaml                # Global app ID and env vars
└── flows/
    ├── app_launch.yaml        # Verify app launches without crashing
    ├── login.yaml             # Login with valid credentials
    ├── login_invalid.yaml     # Login error handling (wrong creds, empty fields)
    ├── onboarding.yaml        # Signup → onboarding tour → dashboard
    ├── navigation.yaml        # Tab bar and screen navigation
    └── subscription.yaml      # Subscription plan selection flow
```

### Configuration

Edit `tests/maestro/config.yaml` to set your app ID and test credentials:

```yaml
appId: com.yourcompany.yoursaasapp  # Replace with your actual app ID

env:
  TEST_EMAIL: "testuser@example.com"
  TEST_PASSWORD: "TestPassword123!"
  API_BASE_URL: "http://localhost:8080"
```

Find your app ID:
- **iOS**: Bundle Identifier in Xcode → target → General tab
- **Android**: `applicationId` in `app/build.gradle`
- **Capacitor**: `appId` in `capacitor.config.ts`
- **React Native**: Bundle ID in `ios/*/Info.plist` and `applicationId` in `android/app/build.gradle`

---

## Writing New Flows

### Basic Flow Template

```yaml
appId: com.yourcompany.yoursaasapp
tags:
  - smoke

---

- launchApp:
    clearState: true

- assertVisible:
    id: "screen-identifier"
    timeout: 10000

- tapOn:
    id: "button-identifier"

- inputText: "some text"

- assertVisible:
    text: "Expected result"

- takeScreenshot: screenshots/flow_name
```

### Common Commands

| Command | Description | Example |
|---------|-------------|---------|
| `launchApp` | Launch or restart the app | `clearState: true` for fresh start |
| `tapOn` | Tap an element | `id: "button-id"` or `text: "Button"` |
| `inputText` | Type text into focused field | `"user@example.com"` |
| `assertVisible` | Assert element is on screen | `id: "element-id"`, `timeout: 5000` |
| `assertNotVisible` | Assert element is NOT on screen | `id: "error-message"` |
| `scrollUntilVisible` | Scroll to find an element | `element: { id: "target" }` |
| `swipe` | Swipe gesture | `direction: LEFT`, `duration: 500` |
| `back` | Press hardware/OS back button | Android and iOS back |
| `hideKeyboard` | Dismiss the keyboard | Useful after text input |
| `waitForAnimationToEnd` | Wait for UI to settle | After transitions |
| `takeScreenshot` | Capture current screen | `screenshots/name` |
| `extendedWaitUntil` | Wait until condition is met | `visible: "text"`, `timeout: 15000` |
| `repeat` | Loop a set of commands | `times: 3` or `while: { visible: "..." }` |
| `runFlow` | Execute another flow file | `runFlow: flows/login.yaml` |
| `evalScript` | Run JavaScript for complex logic | `evalScript: { ... }` |

### Element Targeting (Priority Order)

1. **`id:`** — Accessibility identifier (most reliable)
2. **`text:`** — Visible text content (fragile with i18n)
3. **`index:`** — Nth element of a type (fragile with layout changes)

```yaml
# Best: accessibility identifier
- tapOn:
    id: "login-submit-button"

# Acceptable: visible text (for static labels)
- tapOn:
    text: "Sign In"

# Avoid: index-based (breaks when layout changes)
- tapOn:
    index: 2
```

### Reusing Flows

Use `runFlow` to compose complex tests from smaller building blocks:

```yaml
# tests/maestro/flows/dashboard_actions.yaml
---
# First, log in
- runFlow: login.yaml

# Now test dashboard-specific actions
- tapOn:
    id: "dashboard-create-button"
```

### Conditional Logic

```yaml
# Skip a step if element doesn't exist
- tapOn:
    id: "onboarding-skip-button"
    optional: true

# Repeat until a condition is met
- repeat:
    while:
      notVisible: "Dashboard"
    commands:
      - tapOn:
          id: "next-button"
```

---

## Maestro Studio

Maestro Studio is a visual tool for building and debugging flows:

```bash
maestro studio
```

This opens a browser UI (usually `http://localhost:9999`) that shows:
- A live mirror of your app's current screen
- All available elements with their identifiers
- A command palette for building flows visually

Use it to:
1. Discover element IDs without reading source code
2. Build flows by clicking instead of writing YAML
3. Debug failing tests by stepping through commands

---

## Environment Variables

### In config.yaml (Global)

```yaml
env:
  TEST_EMAIL: "testuser@example.com"
  TEST_PASSWORD: "TestPassword123!"
```

### In flow files (Per-flow Override)

```yaml
env:
  EMAIL: ${TEST_EMAIL}  # Reference global var
  CUSTOM_VAR: "flow-specific-value"
```

### From CLI (Highest Priority)

```bash
maestro test -e TEST_EMAIL=override@test.com tests/maestro/flows/login.yaml
```

### Priority Order

CLI overrides > Flow-level env > Global config.yaml > System env

---

## Integration by Platform

### Capacitor / Ionic

```bash
# Build the iOS app
npx cap sync ios
cd ios/App && xcodebuild -scheme App -sdk iphonesimulator -configuration Debug

# Install on simulator
xcrun simctl install booted ios/App/build/Debug-iphonesimulator/App.app

# Run Maestro tests
maestro test tests/maestro/flows/
```

### React Native

```bash
# Build debug APK (Android)
cd android && ./gradlew assembleDebug
adb install android/app/build/outputs/apk/debug/app-debug.apk

# Build simulator app (iOS)
npx react-native run-ios --configuration Debug

# Run Maestro tests
maestro test tests/maestro/flows/
```

### Flutter

```bash
# Build debug APK
flutter build apk --debug
adb install build/app/outputs/flutter-apk/app-debug.apk

# Build iOS simulator app
flutter build ios --debug --simulator
xcrun simctl install booted build/ios/Debug-iphonesimulator/Runner.app

# Run Maestro tests
maestro test tests/maestro/flows/
```

### Native Swift / Kotlin

```bash
# Build in Xcode, install on simulator, then:
maestro test tests/maestro/flows/
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `No devices found` | Start a simulator (`xcrun simctl boot "iPhone 15"`) or connect a device |
| `App not installed` | Install your app first: `xcrun simctl install booted YourApp.app` |
| `Element not found` | Use `maestro studio` to inspect available elements; check your accessibility identifiers |
| `Timeout waiting for element` | Increase `timeout` value; check if the app is loading slowly |
| `Flow works locally but fails in CI` | Add `timeout` values generously; CI machines are slower |
| `clearState doesn't reset` | On iOS, `clearState` uninstalls and reinstalls. Ensure the app is installed before the flow runs. |
| `Text input not working` | Add `- tapOn: { id: "field-id" }` before `- inputText:` to focus the field |
| `Screenshots not saving` | Check the path in `takeScreenshot`; directory must exist |

---

## Recommended Workflow

1. **New feature?** Write the Maestro flow YAML alongside your feature code
2. **PR review?** Run `maestro test --include-tags=smoke` before pushing
3. **CI/CD?** Run smoke tests on every PR, full regression on merge to main
4. **Bug report?** Record a Maestro flow that reproduces it: `maestro record`
5. **App Store screenshots?** Use `takeScreenshot` in dedicated screenshot flows

---

*See `docs/testing/TESTING_FRAMEWORK_GUIDE.md` for the full testing strategy and `decisions/TESTING_CHOICES.md` for the decision framework.*
