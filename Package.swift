// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ContentLauncher",
    platforms: [.iOS(.v17), .visionOS(.v26)],
    products: [
        .library(
            name: "ContentLauncher",
            targets: ["ContentLauncher"]
        ),
    ],
    targets: [
        .target(
            name: "ContentLauncher"
        ),
        .testTarget(
            name: "ContentLauncherTests",
            dependencies: ["ContentLauncher"]
        ),
    ]
)
