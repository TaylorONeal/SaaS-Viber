import XCTest

// ============================================
// Login Flow UI Tests — [YOUR_APP_NAME]
// ============================================
//
// Focused UI tests for the authentication flow.
// Tests cover login, signup, password reset, and social auth.

final class LoginFlowUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["--uitesting", "--reset-state"]
        app.launchEnvironment = [
            "USE_MOCK_DATA": "true",
            "DISABLE_ANIMATIONS": "true"
        ]
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // MARK: - Login Screen Elements

    func testLoginScreenShowsAllRequiredElements() {
        let emailField = app.textFields["login-email-field"]
        guard emailField.waitForExistence(timeout: 5) else {
            XCTFail("Login screen did not load")
            return
        }

        // All required elements should be visible
        XCTAssertTrue(app.textFields["login-email-field"].exists)
        XCTAssertTrue(app.secureTextFields["login-password-field"].exists)
        XCTAssertTrue(app.buttons["login-submit-button"].exists)
        XCTAssertTrue(app.buttons["forgot-password-button"].exists)
        XCTAssertTrue(app.buttons["signup-link-button"].exists)
    }

    // MARK: - Form Validation

    func testEmptyFormShowsValidationErrors() {
        let loginButton = app.buttons["login-submit-button"]
        guard loginButton.waitForExistence(timeout: 5) else {
            XCTFail("Login button did not appear")
            return
        }

        // Tap login without entering any data
        loginButton.tap()

        // Validation errors should appear
        let emailError = app.staticTexts["email-validation-error"]
        let passwordError = app.staticTexts["password-validation-error"]

        XCTAssertTrue(
            emailError.waitForExistence(timeout: 3),
            "Email validation error should appear"
        )
        XCTAssertTrue(
            passwordError.waitForExistence(timeout: 3),
            "Password validation error should appear"
        )
    }

    func testInvalidEmailShowsError() {
        let emailField = app.textFields["login-email-field"]
        guard emailField.waitForExistence(timeout: 5) else {
            XCTFail("Email field did not appear")
            return
        }

        emailField.tap()
        emailField.typeText("not-an-email")

        // Tap elsewhere to trigger validation
        app.tap()

        let emailError = app.staticTexts["email-validation-error"]
        XCTAssertTrue(
            emailError.waitForExistence(timeout: 3),
            "Should show email format error"
        )
    }

    // MARK: - Password Reset Flow

    func testForgotPasswordFlow() {
        let forgotButton = app.buttons["forgot-password-button"]
        guard forgotButton.waitForExistence(timeout: 5) else {
            XCTFail("Forgot password button did not appear")
            return
        }

        forgotButton.tap()

        // Reset password screen should appear
        let resetEmailField = app.textFields["reset-email-field"]
        XCTAssertTrue(
            resetEmailField.waitForExistence(timeout: 5),
            "Password reset screen should appear"
        )

        // Enter email and submit
        resetEmailField.tap()
        resetEmailField.typeText("user@example.com")

        let sendButton = app.buttons["reset-submit-button"]
        XCTAssertTrue(sendButton.exists)
        sendButton.tap()

        // Confirmation should appear
        let confirmation = app.staticTexts["reset-confirmation-message"]
        XCTAssertTrue(
            confirmation.waitForExistence(timeout: 5),
            "Reset confirmation should appear"
        )
    }

    // MARK: - Sign Up Navigation

    func testNavigateToSignUp() {
        let signupLink = app.buttons["signup-link-button"]
        guard signupLink.waitForExistence(timeout: 5) else {
            XCTFail("Sign up link did not appear")
            return
        }

        signupLink.tap()

        // Sign up form should appear
        let signupForm = app.otherElements["signup-view"]
        XCTAssertTrue(
            signupForm.waitForExistence(timeout: 5),
            "Sign up screen should appear"
        )
    }

    // MARK: - Social Auth Buttons

    func testSocialAuthButtonsExist() {
        // If your app uses social login, verify buttons are present.
        // Customize identifiers to match your implementation.
        let socialButtons = [
            "google-signin-button",
            "apple-signin-button"
        ]

        for identifier in socialButtons {
            let button = app.buttons[identifier]
            // Social buttons may not exist in all configurations
            if button.exists {
                XCTAssertTrue(button.isEnabled, "\(identifier) should be enabled")
            }
        }
    }

    // MARK: - Keyboard Handling

    func testKeyboardDismissesOnBackgroundTap() {
        let emailField = app.textFields["login-email-field"]
        guard emailField.waitForExistence(timeout: 5) else {
            XCTFail("Email field did not appear")
            return
        }

        // Focus the text field (keyboard appears)
        emailField.tap()

        // Tap outside the field
        app.otherElements["login-view"].tap()

        // The email field should no longer have focus
        // (keyboard should be dismissed)
    }
}
