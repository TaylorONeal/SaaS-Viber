# XCTest Setup Guide — [YOUR_APP_NAME]

> **Purpose:** Step-by-step instructions for integrating the XCTest template
> into your iOS/macOS project.
>
> **Prerequisites:**
> - macOS with Xcode 15+ installed
> - An iOS/macOS app target (native Swift, Capacitor, or React Native)
> - Familiarity with Swift basics

---

## Quick Start

### Option A: Swift Package Manager (Standalone)

If you want to run unit tests without a full Xcode project:

```bash
cd tests/xctest
swift test
```

This runs all tests in `Tests/UnitTests/` using the SPM configuration in `Package.swift`.

### Option B: Integrate into Xcode Project

For UI tests and full integration, add the test targets to your Xcode project:

1. **Open your Xcode project** (e.g., `ios/App/App.xcodeproj` for Capacitor)

2. **Add a Unit Test target:**
   - File → New → Target → Unit Testing Bundle
   - Name: `YourAppTests`
   - Language: Swift
   - Copy files from `tests/xctest/Tests/UnitTests/` into this target

3. **Add a UI Test target:**
   - File → New → Target → UI Testing Bundle
   - Name: `YourAppUITests`
   - Language: Swift
   - Copy files from `tests/xctest/Tests/UITests/` into this target

4. **Add the test plan:**
   - Copy `tests/xctest/Tests/TestPlans/SaaSApp.xctestplan` into your project
   - Product → Test Plan → select `SaaSApp.xctestplan`
   - Edit target names in the JSON to match your project

5. **Run tests:** `Cmd+U`

---

## Integration by Platform

### Native Swift App

The test files work as-is. Replace the `SaaSApp` placeholder module with your actual app module:

```swift
// Before
@testable import SaaSApp

// After
@testable import YourActualAppModule
```

### Capacitor / Ionic

Capacitor generates an Xcode project at `ios/App/App.xcodeproj`:

1. Open the Xcode workspace: `ios/App/App.xcworkspace`
2. Add test targets as described above
3. The host application is `App`
4. For UI tests, set the target application to `App`

```swift
// In setUp()
override func setUp() {
    super.setUp()
    app = XCUIApplication()
    // Capacitor apps may need specific launch arguments
    app.launchArguments = ["--uitesting"]
    app.launch()
}
```

### React Native

React Native projects use a different Xcode structure:

1. Open `ios/YourApp.xcworkspace`
2. Add test targets to the main scheme
3. React Native UI is rendered in a `RCTRootView` — element queries use accessibility labels set via `testID` prop in JSX

```swift
// React Native elements use testID as the accessibility identifier
let loginButton = app.buttons["login-submit-button"]
// This matches: <TouchableOpacity testID="login-submit-button" />
```

---

## Test Configuration

### Launch Arguments

Pass flags to your app to enable test mode:

```swift
app.launchArguments = [
    "--uitesting",          // Enable UI testing mode
    "--reset-state",        // Clear persisted data
    "--skip-onboarding",    // Skip first-run experience
    "--mock-api",           // Use mock API responses
]
```

Handle these in your app's launch code:

```swift
// AppDelegate.swift or App.swift
if CommandLine.arguments.contains("--uitesting") {
    // Disable animations for faster, more reliable tests
    UIView.setAnimationsEnabled(false)
}

if CommandLine.arguments.contains("--reset-state") {
    UserDefaults.standard.removePersistentDomain(
        forName: Bundle.main.bundleIdentifier!
    )
}
```

### Environment Variables

```swift
app.launchEnvironment = [
    "API_BASE_URL": "http://localhost:8080",
    "DISABLE_ANIMATIONS": "true",
    "USE_MOCK_DATA": "true",
    "TEST_USER_TOKEN": "test_token_abc123",
]
```

---

## Adding New Tests

### Unit Test

1. Create a new `.swift` file in `Tests/UnitTests/`
2. Import `XCTest` and your app module
3. Create a class extending `XCTestCase`
4. Write methods prefixed with `test`

```swift
import XCTest
@testable import YourApp

final class SubscriptionServiceTests: XCTestCase {
    func testFreeUserCannotAccessProFeatures() {
        let user = User(plan: .free)
        let service = FeatureGateService()
        XCTAssertFalse(service.canAccess(.advancedAnalytics, user: user))
    }
}
```

### UI Test

1. Create a new `.swift` file in `Tests/UITests/`
2. Import `XCTest` only (no `@testable import` — UI tests are black-box)
3. Use `XCUIApplication` to drive the app
4. Query elements by accessibility identifier

```swift
import XCTest

final class SettingsUITests: XCTestCase {
    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launch()
    }

    func testToggleDarkMode() {
        app.tabBars.buttons["Settings"].tap()
        let toggle = app.switches["settings-theme-toggle"]
        XCTAssertTrue(toggle.waitForExistence(timeout: 5))
        toggle.tap()
        // Verify the UI updated (e.g., background color changed)
    }
}
```

---

## Code Coverage

### Enable in Xcode

1. Edit Scheme → Test → Options → Code Coverage → Check "Gather coverage"
2. Run tests (`Cmd+U`)
3. View: Report Navigator → select test run → Coverage tab

### Enable via CLI

```bash
xcodebuild test \
  -scheme YourApp \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -enableCodeCoverage YES \
  -resultBundlePath TestResults.xcresult
```

### View Coverage Report

```bash
xcrun xccov view --report TestResults.xcresult
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| `@testable import` fails | Ensure the test target is in the same scheme and the app module has `ENABLE_TESTABILITY = YES` in build settings |
| UI tests can't find elements | Add `accessibilityIdentifier` to the element in your app code |
| Tests timeout | Increase timeout in `waitForExistence(timeout:)` or check if the app is stuck loading |
| Parallel tests fail | Some UI tests can't run in parallel — set `parallelizable: false` in the test plan |
| `swift test` fails in CI | Ensure the CI runner has Xcode command line tools installed: `xcode-select --install` |

---

*See `docs/testing/TESTING_FRAMEWORK_GUIDE.md` for the full testing strategy and `decisions/TESTING_CHOICES.md` for the decision framework.*
