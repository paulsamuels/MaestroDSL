// swift-tools-version: 5.9

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
