// swift-tools-version: 6.1
// This is a Skip (https://skip.dev) package.
import PackageDescription

let package = Package(
    name: "finda-app",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "FINDA", type: .dynamic, targets: ["FINDA"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.8.2"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "FINDA",
            dependencies: [
                .product(name: "SkipUI", package: "skip-ui")
            ],
            path: "Sources/FINDA",
            exclude: [
                "App/Resources",
            ],
            sources: [
                "ContentView.swift",
                "FINDAApp.swift",
                "ViewModel.swift",
                "DesignSystem",
                "App",
                "Features",
                "Shared",
                "Core",
            ],
            resources: [.process("Resources")],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .testTarget(name: "FINDATests", dependencies: [
            "FINDA",
            .product(name: "SkipTest", package: "skip")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ],
    swiftLanguageModes: [.v5]
)
