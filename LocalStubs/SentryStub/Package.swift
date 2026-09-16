// swift-tools-version:6.0
import PackageDescription

// Local no-op stand-in for sentry-cocoa. Used only for LOCAL builds on Xcode
// toolchains whose SwiftPM rejects sentry-cocoa's (pre-traits) manifest. Not
// for release — telemetry is inert with this in place.
let package = Package(
    name: "SentryStub",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "Sentry", targets: ["Sentry"])
    ],
    targets: [
        .target(name: "Sentry", path: "Sources/Sentry")
    ]
)
