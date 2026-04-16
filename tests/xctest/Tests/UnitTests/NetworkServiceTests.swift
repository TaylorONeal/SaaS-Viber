import XCTest
@testable import SaaSApp

// ============================================
// Network Service Tests — [YOUR_APP_NAME]
// ============================================
//
// Template for testing API/network layer logic.
// Uses protocol-based dependency injection for testability.
//
// Pattern: Define a protocol for the network layer, then inject
// a mock implementation in tests. This avoids real network calls
// and makes tests fast and deterministic.

// MARK: - Protocols (move to your app source)

/// Protocol defining the API client interface.
/// Your production code implements this with real URLSession calls.
/// Tests inject a mock implementation.
protocol APIClientProtocol {
    func fetch<T: Decodable>(endpoint: String) async throws -> T
    func post<T: Encodable, R: Decodable>(endpoint: String, body: T) async throws -> R
}

/// Example response type
struct APIResponse<T: Decodable>: Decodable {
    let data: T?
    let error: String?
    let statusCode: Int
}

// MARK: - Mock API Client

final class MockAPIClient: APIClientProtocol {
    var fetchResult: Any?
    var fetchError: Error?
    var postResult: Any?
    var postError: Error?
    var fetchCallCount = 0
    var postCallCount = 0
    var lastEndpoint: String?

    func fetch<T: Decodable>(endpoint: String) async throws -> T {
        fetchCallCount += 1
        lastEndpoint = endpoint
        if let error = fetchError { throw error }
        guard let result = fetchResult as? T else {
            throw URLError(.badServerResponse)
        }
        return result
    }

    func post<T: Encodable, R: Decodable>(endpoint: String, body: T) async throws -> R {
        postCallCount += 1
        lastEndpoint = endpoint
        if let error = postError { throw error }
        guard let result = postResult as? R else {
            throw URLError(.badServerResponse)
        }
        return result
    }
}

// MARK: - Tests

final class NetworkServiceTests: XCTestCase {

    private var mockClient: MockAPIClient!

    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient()
    }

    override func tearDown() {
        mockClient = nil
        super.tearDown()
    }

    // MARK: - Fetch Tests

    func testFetchSuccess() async throws {
        // Arrange
        let expectedUsers = ["Alice", "Bob"]
        mockClient.fetchResult = expectedUsers

        // Act
        let result: [String] = try await mockClient.fetch(endpoint: "/api/users")

        // Assert
        XCTAssertEqual(result, expectedUsers)
        XCTAssertEqual(mockClient.fetchCallCount, 1)
        XCTAssertEqual(mockClient.lastEndpoint, "/api/users")
    }

    func testFetchNetworkError() async {
        // Arrange
        mockClient.fetchError = URLError(.notConnectedToInternet)

        // Act & Assert
        do {
            let _: [String] = try await mockClient.fetch(endpoint: "/api/users")
            XCTFail("Expected network error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

    func testFetchTracksCallCount() async throws {
        // Arrange
        mockClient.fetchResult = [String]()

        // Act
        let _: [String] = try await mockClient.fetch(endpoint: "/api/a")
        let _: [String] = try await mockClient.fetch(endpoint: "/api/b")

        // Assert
        XCTAssertEqual(mockClient.fetchCallCount, 2)
        XCTAssertEqual(mockClient.lastEndpoint, "/api/b")
    }

    // MARK: - Post Tests

    func testPostSuccess() async throws {
        // Arrange
        struct LoginRequest: Encodable {
            let email: String
            let password: String
        }
        struct LoginResponse: Decodable {
            let token: String
        }

        mockClient.postResult = LoginResponse(token: "abc123")

        // Act
        let response: LoginResponse = try await mockClient.post(
            endpoint: "/api/auth/login",
            body: LoginRequest(email: "user@test.com", password: "password")
        )

        // Assert
        XCTAssertEqual(response.token, "abc123")
        XCTAssertEqual(mockClient.postCallCount, 1)
    }

    func testPostServerError() async {
        // Arrange
        struct EmptyRequest: Encodable {}
        struct EmptyResponse: Decodable {}

        mockClient.postError = URLError(.badServerResponse)

        // Act & Assert
        do {
            let _: EmptyResponse = try await mockClient.post(
                endpoint: "/api/data",
                body: EmptyRequest()
            )
            XCTFail("Expected server error to be thrown")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
