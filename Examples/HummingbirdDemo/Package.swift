// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "HummingbirdDemo",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "App", targets: ["App"])
    ],
    dependencies: [
        // In this demo project we import elementary-htmx from the local file system.
        .package(name: "elementary-htmx", path: "../../"),
        // In a real project add a remote dependency, e.g.
        // .package(url: "https://github.com/elementary-swift/elementary-htmx.git", from: "0.7.0"),
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.28.1"),
        .package(url: "https://github.com/hummingbird-project/hummingbird-websocket.git", from: "2.8.1"),
        .package(url: "https://github.com/hummingbird-community/hummingbird-elementary.git", from: "0.6.0"),
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "1.1.7"),
        .package(url: "https://github.com/swift-server/swift-service-lifecycle.git", from: "2.13.0"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdWebSocket", package: "hummingbird-websocket"),
                .product(name: "HummingbirdWSCompression", package: "hummingbird-websocket"),
                .product(name: "HummingbirdElementary", package: "hummingbird-elementary"),
                .product(name: "ElementaryHTMX4", package: "elementary-htmx"),
                .product(name: "ElementaryHTMX4SSE", package: "elementary-htmx"),
                .product(name: "ElementaryHTMX4WS", package: "elementary-htmx"),
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
                .product(name: "ServiceLifecycle", package: "swift-service-lifecycle"),
            ],
            resources: [
                .copy("Public")
            ]
        )
    ]
)
