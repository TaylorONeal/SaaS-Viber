import XCTest

// ============================================
// UI Test Template — [YOUR_APP_NAME]
// ============================================
//
// UI tests drive the full application through its interface.
// They launch the app in the simulator and interact with elements
// using accessibility identifiers.
//
// Run: Cmd+U in Xcode (select UI test scheme)
//
// IMPORTANT: UI tests require a built host application.
// They will not work with `swift test` alone — use Xcode.
//
// Tips:
// - Always use accessibilityIdentifier for reliable element queries
// - Keep UI tests focused on critical user paths
// - UI tests are slow — don't duplicate unit test coverage here

final class SaaSAppUITests: XCTestCase {

    private var app: XCUIApplication!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()

        // Pass launch arguments to configure the app for testing.
        // Your app should check these to enable test mode.
        app.launchArguments = [
            "--uitesting",
            "--reset-state"
        ]

        // Pass environment variables for test configuration.
        app.launchEnvironment = [
            "API_BASE_URL": "http://localhost:8080",
            "DISABLE_ANIMATIONS": "true",
            "USE_MOCK_DATA": "true"
        ]

        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // MARK: - App Launch

    func testAppLaunches() {
        // Verify the app launches without crashing.
        // The app should show a recognizable first screen.
        XCTAssertTrue(app.wait(for: .runningForeground, timeout: 5))
    }

    // MARK: - Login Flow

    func testLoginWithValidCredentials() {
        // Navigate to login if not already there
        let emailField = app.textFields["login-email-field"]
        let passwordField = app.secureTextFields["login-password-field"]
        let loginButton = app.buttons["login-submit-button"]

        // Wait for the login screen to appear
        guard emailField.waitForExistence(timeout: 5) else {
            XCTFail("Login screen did not appear")
            return
        }

        // Enter credentials
        emailField.tap()
        emailField.typeText("test@example.com")

        passwordField.tap()
        passwordField.typeText("TestPassword123!")

        // Submit
        loginButton.tap()

        // Verify navigation to the dashboard
        let dashboard = app.otherElements["dashboard-view"]
        XCTAssertTrue(
            dashboard.waitForExistence(timeout: 10),
            "Should navigate to dashboard after successful login"
        )
    }

    func testLoginWithInvalidCredentials() {
        let emailField = app.textFields["login-email-field"]
        let passwordField = app.secureTextFields["login-password-field"]
        let loginButton = app.buttons["login-submit-button"]

        guard emailField.waitForExistence(timeout: 5) else {
            XCTFail("Login screen did not appear")
            return
        }

        emailField.tap()
        emailField.typeText("wrong@example.com")

        passwordField.tap()
        passwordField.typeText("WrongPassword")

        loginButton.tap()

        // Verify error message appears
        let errorMessage = app.staticTexts["login-error-message"]
        XCTAssertTrue(
            errorMessage.waitForExistence(timeout: 5),
            "Error message should appear for invalid credentials"
        )
    }

    // MARK: - Navigation

    func testMainTabNavigation() {
        // Skip login if needed (assumes test mode auto-authenticates)
        let tabBar = app.tabBars.firstMatch

        guard tabBar.waitForExistence(timeout: 10) else {
            XCTFail("Tab bar did not appear")
            return
        }

        // Test each main tab
        let tabs = ["Home", "Search", "Profile", "Settings"]

        for tabName in tabs {
            let tab = tabBar.buttons[tabName]
            if tab.exists {
                tab.tap()
                // Verify the corresponding view loaded
                // Customize these identifiers for your app
                let view = app.otherElements["\(tabName.lowercased())-view"]
                XCTAssertTrue(
                    view.waitForExistence(timeout: 3),
                    "\(tabName) view should appear when tab is tapped"
                )
            }
        }
    }

    // MARK: - Accessibility

    func testAccessibilityLabelsExist() {
        // Verify critical interactive elements have accessibility labels.
        // This catches missing labels that break VoiceOver.

        let criticalElements: [(String, String)] = [
            ("login-email-field", "Email text field"),
            ("login-password-field", "Password secure text field"),
            ("login-submit-button", "Login button"),
        ]

        for (identifier, description) in criticalElements {
            let element = app.descendants(matching: .any)[identifier]
            if element.exists {
                XCTAssertFalse(
                    element.label.isEmpty,
                    "\(description) (\(identifier)) should have an accessibility label"
                )
            }
        }
    }

    // MARK: - Screenshot Capture

    func testCaptureScreenshotsForAppStore() {
        // Use this test to auto-generate App Store screenshots.
        // Run with: xcodebuild test -scheme YourApp -testPlan Screenshots
        //
        // Pair with fastlane snapshot for automated localized screenshots.

        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
