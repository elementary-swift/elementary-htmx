// swift-tools-version: 6.2
import PackageDescription

// Test server for the ElementaryHTMX4 integration tests.
// Public/ vendors htmx.org@4.0.0 (dist/htmx.min.js, dist/ext/hx-sse.min.js, dist/ext/hx-ws.min.js), unmodified from the npm tarball.
let package = Package(
    name: "IntegrationTestServer",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "IntegrationTestServer", targets: ["IntegrationTestServer"])
    ],
    dependencies: [
        .package(name: "elementary-htmx", path: "../../"),
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird-websocket.git", from: "2.0.0"),
        .package(url: "https://github.com/hummingbird-community/hummingbird-elementary.git", from: "0.4.0"),
    ],
    targets: [
        .executableTarget(
            name: "IntegrationTestServer",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdWebSocket", package: "hummingbird-websocket"),
                .product(name: "HummingbirdElementary", package: "hummingbird-elementary"),
                .product(name: "ElementaryHTMX4", package: "elementary-htmx"),
                .product(name: "ElementaryHTMX4SSE", package: "elementary-htmx"),
                .product(name: "ElementaryHTMX4WS", package: "elementary-htmx"),
            ],
            resources: [
                .copy("Public")
            ]
        )
    ]
)
