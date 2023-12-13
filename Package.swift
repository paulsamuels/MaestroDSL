// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "MaestroDSL",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "MaestroDSL", targets: ["MaestroDSL"]),
        .library(name: "MaestroDSLMacro", targets: ["MaestroDSLMacro"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.6"),
        .package(url: "https://github.com/pointfreeco/swift-macro-testing", from: "0.2.2"),
    ],
    targets: [
        .target(name: "MaestroDSL", dependencies: ["Yams"]),
        .testTarget(name: "MaestroDSLTests", dependencies: ["MaestroDSL"]),
        .macro(
            name: "MaestroDSLMacroMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            ]
        ),
        .target(name: "MaestroDSLMacro", dependencies: ["MaestroDSL", "MaestroDSLMacroMacros"]),
        .testTarget(
            name: "MaestroDSLMacroTests",
            dependencies: [
                "MaestroDSLMacroMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
                .product(name: "MacroTesting", package: "swift-macro-testing"),
            ]
        ),
    ]
)
