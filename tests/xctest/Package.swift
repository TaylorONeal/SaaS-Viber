// swift-tools-version: 5.9
// ============================================
// [YOUR_APP_NAME] XCTest Configuration
// ============================================
//
// This Swift Package Manager configuration defines the test targets
// for your iOS/macOS application. It is used when running tests via
// `swift test` or through Xcode's test navigator.
//
// SETUP:
// 1. Open this package in Xcode: File > Open > select this directory
// 2. Or integrate into your existing Xcode project/workspace
// 3. See docs/testing/XCTEST_SETUP.md for full instructions

import PackageDescription

let package = Package(
    name: "SaaSAppTests",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // The main library target is a placeholder for the app code
        // that test targets depend on. Replace with your actual app module.
        .library(
            name: "SaaSApp",
            targets: ["SaaSApp"]
        )
    ],
    dependencies: [
        // TEMPLATE: Add test-only dependencies here.
        // Common choices:
        // .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.15.0"),
        // .package(url: "https://github.com/Quick/Quick", from: "7.0.0"),
        // .package(url: "https://github.com/Quick/Nimble", from: "13.0.0"),
    ],
    targets: [
        // ------------------------------------------
        // App Source (placeholder)
        // ------------------------------------------
        // Replace this with your actual app module or remove it
        // if your Xcode project already defines the app target.
        .target(
            name: "SaaSApp",
            path: "Sources"
        ),

        // ------------------------------------------
        // Unit Tests
        // ------------------------------------------
        // Fast, isolated tests for business logic, services,
        // view models, and utilities. No UI or host app required.
        .testTarget(
            name: "SaaSAppUnitTests",
            dependencies: ["SaaSApp"],
            path: "Tests/UnitTests"
        ),

        // ------------------------------------------
        // UI Tests
        // ------------------------------------------
        // End-to-end tests that drive the app UI via XCUIApplication.
        // These require a host app and run in the simulator.
        .testTarget(
            name: "SaaSAppUITests",
            dependencies: ["SaaSApp"],
            path: "Tests/UITests"
        ),
    ]
)
