// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "spotify-api-kit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "SpotifyAPIKit",
                 targets: ["SpotifyAPIKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/antarianLogic/interchange", from: "1.0.4"),
        .package(url: "https://github.com/antarianLogic/json-utils", from: "1.0.0")
    ],
    targets: [
        .target(name: "SpotifyAPIKit",
                dependencies: [.product(name: "Interchange", package: "interchange"),
                               .product(name: "JSONUtils", package: "json-utils")],
                resources: [.copy("DataPresets/JSON")]),
        .testTarget(name: "SpotifyAPIKitTests",
                    dependencies: ["SpotifyAPIKit"]),
    ]
)
