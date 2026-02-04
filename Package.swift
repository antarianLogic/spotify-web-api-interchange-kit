// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "spotify-web-api-interchange-kit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "SpotifyWebAPIInterchangeKit",
                 targets: ["SpotifyWebAPIInterchangeKit"]),
        .library(name: "SpotifyWebAPIDataPresets",
                 targets: ["SpotifyWebAPIDataPresets"])
    ],
    dependencies: [
        .package(url: "https://github.com/antarianLogic/interchange", from: "1.0.4")
    ],
    targets: [
        .target(name: "SpotifyWebAPIInterchangeKit",
                dependencies: [.product(name: "Interchange", package: "interchange")]),
        .target(name: "SpotifyWebAPIDataPresets",
                dependencies: ["SpotifyWebAPIInterchangeKit"],
                resources: [.copy("JSON")]),
        .testTarget(name: "SpotifyWebAPIInterchangeKitTests",
                    dependencies: ["SpotifyWebAPIInterchangeKit",
                                   "SpotifyWebAPIDataPresets"]),
    ]
)
