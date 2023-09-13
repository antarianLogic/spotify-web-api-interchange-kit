// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "spotify-api-kit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(name: "SpotifyAPIKit",
                 targets: ["SpotifyAPIKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/antarianLogic/rest-web-service", from: "0.6.0"),
        .package(url: "https://github.com/antarianLogic/json-utils", from: "0.3.0")
    ],
    targets: [
        .target(name: "SpotifyAPIKit",
                dependencies: [.product(name: "RESTWebService", package: "rest-web-service"),
                               .product(name: "JSONUtils", package: "json-utils")],
                resources: [.copy("DataPresets/JSON")]),
//                swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]),
        .testTarget(name: "SpotifyAPIKitTests",
                    dependencies: ["SpotifyAPIKit"]),
    ]
)
