// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StarterProject",
    platforms: [
        .macOS(.v10_15)
    ],
    dependencies: [
        .package(url: "https://github.com/paulsamuels/MaestroDSL.git", branch: "main")
    ],
    targets: [
        .executableTarget(name: "StarterProject", dependencies: [
            .product(name: "MaestroDSL", package: "MaestroDSL"),
            .product(name: "MaestroDSLMacro", package: "MaestroDSL"),
        ]),
    ]
)