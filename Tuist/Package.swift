// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription
    import EnvironmentPlugin

    let packageSettings = PackageSettings(
        productTypes: [
            "KeychainSwift": .framework,
            "ComposableArchitecture": .framework
        ],
        baseSettings: .settings(
            base: env.baseSetting,
            configurations: [
                .debug(name:  "STAGE"),
                .release(name: "PROD")
            ]
        )
    )
#endif

let package = Package(
    name: "FINDAPackage",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.23.1"),
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.3"),
        .package(url: "https://github.com/evgenyneu/keychain-swift.git", from: "24.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.6.2")
    ]
)
