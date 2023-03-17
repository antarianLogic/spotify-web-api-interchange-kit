// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SpotifyAPIKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SpotifyAPIKit",
            targets: ["SpotifyAPIKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/antarianLogic/rest-web-service", from: "0.5.5"),
        .package(url: "https://github.com/antarianLogic/json-utils", from: "0.2.0")
    ],
    targets: [
        .target(
            name: "SpotifyAPIKit",
            dependencies: [.product(name: "RESTWebService", package: "rest-web-service"),
                           .product(name: "JSONUtils", package: "json-utils")],
            resources: [.copy("DataPresets/JSON")]
        ),
        .testTarget(
            name: "SpotifyAPIKitTests",
            dependencies: ["SpotifyAPIKit"]),
    ]
)
