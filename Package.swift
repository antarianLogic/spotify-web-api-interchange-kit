// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpotifyAPIKit",
    platforms: [
        .iOS("15.0"),
        .macOS("12.0")
    ],
    products: [
        .library(
            name: "SpotifyAPIKit",
            targets: ["SpotifyAPIKit"]),
    ],
    dependencies: [
        .package(name: "RESTWebService", url: "https://github.com/nsgeek/rest-web-service.git", from: "0.3.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SpotifyAPIKit",
            dependencies: ["RESTWebService"]),
        .testTarget(
            name: "SpotifyAPIKitTests",
            dependencies: ["SpotifyAPIKit"]),
    ]
)
