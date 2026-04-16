# Testing Framework Guide — [YOUR_APP_NAME]

> **Purpose:** Comprehensive guide for setting up and using XCTest and Maestro
> in your SaaS application. Includes setup instructions, best practices,
> CI/CD integration, and a decision framework for choosing the right tool.
>
> **Related Docs:**
> - `decisions/TESTING_CHOICES.md` — Decision matrix and stack recommendations
> - `docs/testing/XCTEST_SETUP.md` — Detailed XCTest setup instructions
> - `docs/testing/MAESTRO_SETUP.md` — Detailed Maestro setup instructions
> - `docs/architecture/MOBILE_ARCHITECTURE.md` — Mobile platform decisions

---

## Quick Reference: Which Framework Do I Use?

| I want to test... | Use | Location |
|---|---|---|
| Business logic (models, utils, services) | XCTest (unit) | `tests/xctest/Tests/UnitTests/` |
| iOS-native UI interactions | XCTest (UI) | `tests/xctest/Tests/UITests/` |
| Performance (measure execution time) | XCTest (performance) | `tests/xctest/Tests/UnitTests/` |
| Complete user flows (login, onboarding) | Maestro | `tests/maestro/flows/` |
| Cross-platform flows (iOS + Android) | Maestro | `tests/maestro/flows/` |
| Screenshot generation | Maestro or XCTest UI | Either |
| API/network layer (mocked) | XCTest (unit) | `tests/xctest/Tests/UnitTests/` |
| Web components (React) | Vitest + Testing Library | `src/**/*.test.ts` |
| Browser E2E | Playwright or Cypress | `tests/e2e/` |

---

## Part 1: XCTest

### What Is XCTest?

XCTest is Apple's built-in testing framework for iOS, macOS, watchOS, and tvOS. It ships with Xcode and requires no additional installation. It supports three categories of tests:

1. **Unit Tests** — Test isolated functions, classes, and logic. No UI, no network. Run in milliseconds.
2. **UI Tests (XCUITest)** — Drive the app's UI through simulated user interaction. Run in the simulator.
3. **Performance Tests** — Measure execution time of code blocks. Xcode tracks baselines and alerts on regressions.

### Project Structure

```
tests/xctest/
├── Package.swift                    # Swift Package Manager config
├── Sources/
│   └── SaaSApp.swift                # Placeholder app module
└── Tests/
    ├── UnitTests/
    │   ├── SaaSAppTests.swift       # General unit tests
    │   ├── NetworkServiceTests.swift # API layer tests with mocks
    │   └── AuthenticationTests.swift # Auth flow tests
    ├── UITests/
    │   ├── SaaSAppUITests.swift     # Core UI tests
    │   └── LoginFlowUITests.swift   # Login-specific UI tests
    └── TestPlans/
        └── SaaSApp.xctestplan       # Multi-configuration test plan
```

### Running XCTests

```bash
# Run all unit tests via Swift Package Manager
cd tests/xctest && swift test

# Run a specific test target
cd tests/xctest && swift test --filter SaaSAppUnitTests

# Run a specific test method
cd tests/xctest && swift test --filter SaaSAppUnitTests.SaaSAppTests/testEmailValidation

# Run via Xcode (includes UI tests)
# Open tests/xctest/Package.swift in Xcode, then Cmd+U

# Run via xcodebuild (CI/CD)
xcodebuild test \
  -scheme SaaSApp \
  -destination 'platform=iOS Simulator,name=iPhone 15,OS=17.0' \
  -testPlan SaaSApp \
  -resultBundlePath TestResults.xcresult
```

### Writing Good XCTests

```swift
// Pattern: Arrange → Act → Assert
func testUserCanUpdateDisplayName() {
    // Arrange
    let user = User(id: "123", name: "Old Name", email: "user@test.com")

    // Act
    let updated = user.withName("New Name")

    // Assert
    XCTAssertEqual(updated.name, "New Name")
    XCTAssertEqual(updated.id, "123")      // unchanged
    XCTAssertEqual(updated.email, "user@test.com") // unchanged
}
```

### Key Patterns in the Template

| Pattern | File | Description |
|---------|------|-------------|
| Basic assertions | `SaaSAppTests.swift` | `XCTAssertEqual`, `XCTAssertTrue`, `XCTAssertFalse` |
| Async tests | `SaaSAppTests.swift` | `async throws` tests with `XCTestExpectation` |
| Performance tests | `SaaSAppTests.swift` | `measure { }` blocks |
| Protocol-based mocks | `NetworkServiceTests.swift` | Inject mock API clients via protocols |
| State machine tests | `AuthenticationTests.swift` | Test enum-based state transitions |
| Token storage mocks | `AuthenticationTests.swift` | Mock Keychain interactions |
| UI element queries | `SaaSAppUITests.swift` | `app.textFields["id"]`, `app.buttons["id"]` |
| Launch configuration | `SaaSAppUITests.swift` | `launchArguments`, `launchEnvironment` |
| Form validation | `LoginFlowUITests.swift` | Test empty fields, invalid input |
| Accessibility checks | `SaaSAppUITests.swift` | Verify labels exist on interactive elements |
| Screenshot capture | `SaaSAppUITests.swift` | `XCTAttachment(screenshot:)` |

### Test Plan Configuration

The included `SaaSApp.xctestplan` defines three configurations:

| Configuration | Purpose |
|---|---|
| Default | Standard English (US) testing |
| Dark Mode | Tests UI in dark appearance |
| Accessibility (Large Text) | Tests with increased text sizes |

Test plans are edited in Xcode: Product → Test Plan → Edit Test Plan.

---

## Part 2: Maestro

### What Is Maestro?

Maestro is an open-source mobile UI testing framework built by mobile.dev. Tests are written in YAML — no programming language required. It works with any mobile framework (native, React Native, Flutter, Capacitor) and supports both iOS and Android from a single flow file.

### Installation

```bash
# macOS / Linux
curl -Ls "https://get.maestro.mobile.dev" | bash

# Verify installation
maestro --version

# Optional: Install Maestro Studio for visual flow building
maestro studio
```

### Project Structure

```
tests/maestro/
├── config.yaml                # Global configuration and env vars
└── flows/
    ├── app_launch.yaml        # App launch verification
    ├── login.yaml             # Login with valid credentials
    ├── login_invalid.yaml     # Login error handling
    ├── onboarding.yaml        # First-time user signup + tour
    ├── navigation.yaml        # Tab bar and screen transitions
    └── subscription.yaml      # Subscription plan selection
```

### Running Maestro Tests

```bash
# Run all flows
maestro test tests/maestro/flows/

# Run a single flow
maestro test tests/maestro/flows/login.yaml

# Run with tag filter
maestro test --include-tags=smoke tests/maestro/flows/

# Run with environment variable overrides
maestro test -e EMAIL=custom@test.com tests/maestro/flows/login.yaml

# Run in continuous mode (re-runs on file change)
maestro test --continuous tests/maestro/flows/login.yaml

# Open Maestro Studio (visual flow builder)
maestro studio

# Record a flow from manual interaction
maestro record tests/maestro/flows/new_flow.yaml
```

### Writing Good Maestro Flows

```yaml
# Use accessibility IDs — they survive UI refactors
- tapOn:
    id: "login-submit-button"     # Good: stable identifier

# Avoid matching by text when possible — text changes with i18n
- tapOn:
    text: "Submit"                 # Fragile: breaks when translated

# Use optional: true for elements that may not exist in all configs
- tapOn:
    id: "onboarding-skip-button"
    optional: true

# Use env vars for test data — don't hardcode credentials
- inputText: ${TEST_EMAIL}

# Always take screenshots at key checkpoints
- takeScreenshot: screenshots/step_name
```

### Key Patterns in the Template

| Pattern | File | Description |
|---------|------|-------------|
| Clean launch | `app_launch.yaml` | `clearState: true` for fresh start |
| Env variable substitution | `login.yaml` | `${EMAIL}` from config or CLI |
| Element waiting | `app_launch.yaml` | `extendedWaitUntil` for slow loads |
| Existence assertions | `login.yaml` | `assertVisible` / `assertNotVisible` |
| Optional elements | `navigation.yaml` | `optional: true` for conditional UI |
| Screenshot capture | All flows | `takeScreenshot` at checkpoints |
| Form input | `onboarding.yaml` | `tapOn` + `inputText` sequence |
| Negative testing | `login_invalid.yaml` | Verify error states |
| Multi-step flow | `onboarding.yaml` | Signup → tour → dashboard |

### Maestro Studio

Maestro Studio is a visual tool for building flows interactively:

```bash
maestro studio
```

It opens a browser UI that shows your app's current screen, lets you tap elements, and generates the YAML for you. Use it to:
- Discover element identifiers without reading source code
- Prototype flows quickly before polishing the YAML
- Debug failing flows by stepping through them visually

---

## Part 3: CI/CD Integration

### GitHub Actions — XCTest

```yaml
# .github/workflows/xctest.yml
name: XCTest
on:
  pull_request:
    paths:
      - 'tests/xctest/**'
      - 'ios/**'

jobs:
  test:
    runs-on: macos-14
    steps:
      - uses: actions/checkout@v4

      - name: Select Xcode
        run: sudo xcode-select -s /Applications/Xcode_15.4.app

      - name: Run unit tests
        working-directory: tests/xctest
        run: swift test

      - name: Run UI tests (requires Xcode project)
        run: |
          xcodebuild test \
            -scheme YourApp \
            -destination 'platform=iOS Simulator,name=iPhone 15' \
            -testPlan SaaSApp \
            -resultBundlePath ${{ runner.temp }}/TestResults.xcresult

      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: test-results
          path: ${{ runner.temp }}/TestResults.xcresult
```

### GitHub Actions — Maestro

```yaml
# .github/workflows/maestro.yml
name: Maestro
on:
  pull_request:
    paths:
      - 'tests/maestro/**'
      - 'src/**'
      - 'ios/**'
      - 'android/**'

jobs:
  test:
    runs-on: macos-14
    steps:
      - uses: actions/checkout@v4

      - name: Install Maestro
        run: curl -Ls "https://get.maestro.mobile.dev" | bash

      - name: Start iOS Simulator
        run: |
          xcrun simctl boot "iPhone 15"
          xcrun simctl status_bar "iPhone 15" override \
            --time "9:41" --batteryLevel 100 --batteryState charged

      - name: Build and install app
        run: |
          # Replace with your actual build command
          xcodebuild -scheme YourApp \
            -destination 'platform=iOS Simulator,name=iPhone 15' \
            -derivedDataPath build/
          xcrun simctl install booted build/Build/Products/Debug-iphonesimulator/YourApp.app

      - name: Run Maestro smoke tests
        run: |
          export PATH="$PATH:$HOME/.maestro/bin"
          maestro test --include-tags=smoke tests/maestro/flows/

      - name: Upload screenshots
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: maestro-screenshots
          path: tests/maestro/flows/screenshots/
```

### Maestro Cloud (Managed CI)

Maestro Cloud runs your flows on real devices without managing infrastructure:

```bash
# Upload and run flows on Maestro Cloud
maestro cloud \
  --app-file=YourApp.app \
  tests/maestro/flows/

# With API key (for CI)
MAESTRO_CLOUD_API_KEY=your_key maestro cloud \
  --app-file=YourApp.app \
  --include-tags=smoke \
  tests/maestro/flows/
```

---

## Part 4: Best Practices

### General

1. **Test the right things at the right level.** Unit tests for logic, E2E tests for user flows. Don't test implementation details in E2E, don't test full flows in unit tests.

2. **Use accessibility identifiers everywhere.** Both XCTest UI and Maestro rely on them. Add `accessibilityIdentifier` (iOS) or `testID` (React Native) to every interactive element.

3. **Keep tests independent.** Each test should set up its own state and not depend on other tests running first. Use `clearState: true` in Maestro and `setUp()` in XCTest.

4. **Use mock data in tests.** Never hit real APIs or real payment systems in tests. Configure your app to use mock data when launched with test flags.

5. **Run tests in CI on every PR.** Smoke tests on every push, full regression on merge to main.

### XCTest-Specific

- Prefer `async/await` over completion handlers in tests
- Use `XCTestExpectation` for operations that can't be made async
- Add `measure { }` blocks to performance-sensitive code paths
- Use test plans for multi-configuration testing (dark mode, accessibility, locales)
- Name tests descriptively: `testLoginWithExpiredTokenRefreshesAndRetries`

### Maestro-Specific

- Use `id:` (accessibility identifier) over `text:` for element targeting
- Always set `optional: true` for elements that may not exist across platforms
- Take screenshots at every major checkpoint for debugging failures
- Use `config.yaml` for shared environment variables
- Tag flows (`smoke`, `regression`, `auth`) and run subsets in CI

---

## Part 5: Accessibility Identifier Convention

Both frameworks depend on consistent accessibility identifiers. Use this naming convention:

```
[screen]-[element-type]-[purpose]
```

| Example | Meaning |
|---------|---------|
| `login-email-field` | Email text field on the login screen |
| `login-submit-button` | Submit button on the login screen |
| `dashboard-view` | Root view of the dashboard screen |
| `profile-avatar-image` | Avatar image on the profile screen |
| `settings-theme-toggle` | Theme toggle on the settings screen |
| `signup-terms-checkbox` | Terms checkbox on the signup screen |

### React / React Native

```tsx
// React Native
<TextInput testID="login-email-field" />

// React (web, for Capacitor wrapper)
<input data-testid="login-email-field" />
```

### Swift / SwiftUI

```swift
// UIKit
emailField.accessibilityIdentifier = "login-email-field"

// SwiftUI
TextField("Email", text: $email)
    .accessibilityIdentifier("login-email-field")
```

---

*For the decision framework on which tool to use for your specific stack, see `decisions/TESTING_CHOICES.md`.*
