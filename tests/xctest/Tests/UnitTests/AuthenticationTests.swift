import XCTest
@testable import SaaSApp

// ============================================
// Authentication Tests — [YOUR_APP_NAME]
// ============================================
//
// Template for testing authentication flows.
// Covers token management, session state, and auth validation.

// MARK: - Auth Types (move to your app source)

enum AuthState: Equatable {
    case unauthenticated
    case authenticating
    case authenticated(userId: String)
    case expired
    case error(String)

    static func == (lhs: AuthState, rhs: AuthState) -> Bool {
        switch (lhs, rhs) {
        case (.unauthenticated, .unauthenticated),
             (.authenticating, .authenticating),
             (.expired, .expired):
            return true
        case let (.authenticated(l), .authenticated(r)):
            return l == r
        case let (.error(l), .error(r)):
            return l == r
        default:
            return false
        }
    }
}

struct AuthToken {
    let accessToken: String
    let refreshToken: String
    let expiresAt: Date

    var isExpired: Bool {
        Date() >= expiresAt
    }
}

protocol TokenStorageProtocol {
    func save(token: AuthToken) throws
    func load() -> AuthToken?
    func clear()
}

// MARK: - Mock Token Storage

final class MockTokenStorage: TokenStorageProtocol {
    var savedToken: AuthToken?
    var shouldThrowOnSave = false
    var clearCallCount = 0

    func save(token: AuthToken) throws {
        if shouldThrowOnSave {
            throw NSError(domain: "TokenStorage", code: 1, userInfo: [
                NSLocalizedDescriptionKey: "Keychain write failed"
            ])
        }
        savedToken = token
    }

    func load() -> AuthToken? {
        savedToken
    }

    func clear() {
        clearCallCount += 1
        savedToken = nil
    }
}

// MARK: - Tests

final class AuthenticationTests: XCTestCase {

    private var tokenStorage: MockTokenStorage!

    override func setUp() {
        super.setUp()
        tokenStorage = MockTokenStorage()
    }

    override func tearDown() {
        tokenStorage = nil
        super.tearDown()
    }

    // MARK: - Token Tests

    func testTokenNotExpired() {
        let token = AuthToken(
            accessToken: "access_123",
            refreshToken: "refresh_456",
            expiresAt: Date().addingTimeInterval(3600) // 1 hour from now
        )
        XCTAssertFalse(token.isExpired)
    }

    func testTokenExpired() {
        let token = AuthToken(
            accessToken: "access_123",
            refreshToken: "refresh_456",
            expiresAt: Date().addingTimeInterval(-1) // 1 second ago
        )
        XCTAssertTrue(token.isExpired)
    }

    // MARK: - Token Storage Tests

    func testSaveAndLoadToken() throws {
        let token = AuthToken(
            accessToken: "access_abc",
            refreshToken: "refresh_def",
            expiresAt: Date().addingTimeInterval(3600)
        )

        try tokenStorage.save(token: token)
        let loaded = tokenStorage.load()

        XCTAssertNotNil(loaded)
        XCTAssertEqual(loaded?.accessToken, "access_abc")
        XCTAssertEqual(loaded?.refreshToken, "refresh_def")
    }

    func testClearToken() throws {
        let token = AuthToken(
            accessToken: "access_abc",
            refreshToken: "refresh_def",
            expiresAt: Date().addingTimeInterval(3600)
        )

        try tokenStorage.save(token: token)
        tokenStorage.clear()

        XCTAssertNil(tokenStorage.load())
        XCTAssertEqual(tokenStorage.clearCallCount, 1)
    }

    func testSaveTokenFailure() {
        tokenStorage.shouldThrowOnSave = true

        let token = AuthToken(
            accessToken: "access_abc",
            refreshToken: "refresh_def",
            expiresAt: Date().addingTimeInterval(3600)
        )

        XCTAssertThrowsError(try tokenStorage.save(token: token)) { error in
            XCTAssertEqual(
                (error as NSError).domain,
                "TokenStorage"
            )
        }
    }

    // MARK: - Auth State Tests

    func testAuthStateTransitions() {
        var state: AuthState = .unauthenticated
        XCTAssertEqual(state, .unauthenticated)

        state = .authenticating
        XCTAssertEqual(state, .authenticating)

        state = .authenticated(userId: "user_123")
        XCTAssertEqual(state, .authenticated(userId: "user_123"))
        XCTAssertNotEqual(state, .authenticated(userId: "user_456"))

        state = .expired
        XCTAssertEqual(state, .expired)

        state = .error("Network timeout")
        XCTAssertEqual(state, .error("Network timeout"))
        XCTAssertNotEqual(state, .error("Different error"))
    }

    // MARK: - Password Validation

    func testPasswordStrength() {
        // Minimum 8 chars, at least one uppercase, one lowercase, one digit
        XCTAssertTrue(isStrongPassword("Abcdef1!"))
        XCTAssertTrue(isStrongPassword("MyP@ssw0rd"))

        XCTAssertFalse(isStrongPassword("short1A"))        // too short
        XCTAssertFalse(isStrongPassword("alllowercase1"))   // no uppercase
        XCTAssertFalse(isStrongPassword("ALLUPPERCASE1"))   // no lowercase
        XCTAssertFalse(isStrongPassword("NoDigitsHere!"))   // no digit
        XCTAssertFalse(isStrongPassword(""))                // empty
    }

    // MARK: - Helpers

    private func isStrongPassword(_ password: String) -> Bool {
        guard password.count >= 8 else { return false }
        let hasUpper = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLower = password.range(of: "[a-z]", options: .regularExpression) != nil
        let hasDigit = password.range(of: "[0-9]", options: .regularExpression) != nil
        return hasUpper && hasLower && hasDigit
    }
}
