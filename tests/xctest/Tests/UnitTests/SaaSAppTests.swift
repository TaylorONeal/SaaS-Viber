import XCTest
@testable import SaaSApp

// ============================================
// Unit Test Template — [YOUR_APP_NAME]
// ============================================
//
// Unit tests verify isolated business logic without UI or network.
// Keep these fast (< 1s per test) and deterministic.
//
// Run: Cmd+U in Xcode, or `swift test --filter SaaSAppUnitTests`

final class SaaSAppTests: XCTestCase {

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()
        // Reset shared state, configure test doubles, etc.
    }

    override func tearDown() {
        // Clean up resources, reset singletons, etc.
        super.tearDown()
    }

    // MARK: - Example: Version

    func testAppVersionIsSet() {
        XCTAssertFalse(SaaSApp.version.isEmpty, "App version should not be empty")
    }

    // MARK: - Example: Model Validation
    // Replace with your actual model tests.

    func testEmailValidation() {
        // Example: validating user input
        let validEmails = ["user@example.com", "name+tag@domain.co"]
        let invalidEmails = ["", "not-an-email", "@domain.com", "user@"]

        for email in validEmails {
            XCTAssertTrue(
                isValidEmail(email),
                "\(email) should be valid"
            )
        }

        for email in invalidEmails {
            XCTAssertFalse(
                isValidEmail(email),
                "\(email) should be invalid"
            )
        }
    }

    // MARK: - Example: Async Operation

    func testAsyncDataFetch() async throws {
        // Example: testing an async service method
        // Replace with your actual service under test.
        let expectation = XCTestExpectation(description: "Data should load")

        // Simulate async work
        Task {
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1s
            expectation.fulfill()
        }

        await fulfillment(of: [expectation], timeout: 2.0)
    }

    // MARK: - Example: Performance

    func testPerformanceOfHeavyComputation() {
        // Measures execution time. Xcode records baselines
        // and alerts you when performance regresses.
        measure {
            _ = (0..<1000).reduce(0, +)
        }
    }

    // MARK: - Helpers

    /// Simple email regex for demonstration.
    /// Replace with your actual validation logic.
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return email.range(of: pattern, options: .regularExpression) != nil
    }
}
