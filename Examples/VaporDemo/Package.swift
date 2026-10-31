// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "VaporDemo",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "App", targets: ["App"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.122.3"),
        .package(url: "https://github.com/vapor-community/vapor-elementary.git", from: "0.2.2"),
        // In this demo project we import elementary-htmx from the local file system.
        .package(name: "elementary-htmx", path: "../../"),
        // In a real project add a remote dependency, e.g.
        // .package(url: "https://github.com/elementary-swift/elementary-htmx.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "1.1.7"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "VaporElementary", package: "vapor-elementary"),
                .product(name: "ElementaryHTMX4", package: "elementary-htmx"),
                .product(name: "ElementaryHTMX4SSE", package: "elementary-htmx"),
                .product(name: "ElementaryHTMX4WS", package: "elementary-htmx"),
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ],
            resources: [
                .copy("Public")
            ]
        )
    ]
)
