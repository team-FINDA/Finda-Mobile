import Foundation
import ProjectDescription
import ProjectDescriptionHelpers
import EnvironmentPlugin
import DependencyPlugin
import ConfigurationPlugin

let isCI: Bool = (ProcessInfo.processInfo.environment["TUIST_CI"] ?? "0") == "1"

let configurations: [Configuration] = [
    .debug(name: .dev, xcconfig: .relativeToXCConfig(type: .dev, name: env.targetName)),
    .release(name: .prod, xcconfig: .relativeToXCConfig(type: .prod, name: env.targetName))
]

let settings: Settings = .settings(
    base: env.baseSetting,
    configurations: configurations,
    defaultSettings: .recommended
)

let scripts: [TargetScript] = isCI ? [] : [.swiftLint]

let targets: [Target] = [
    .target(
        name: env.targetName,
        destinations: env.destination,
        product: .app,
        bundleId: "$(APP_BUNDLE_ID)",
        deploymentTargets: env.deploymentTargets,
        infoPlist: .file(path: "Support/Info.plist"),
        sources: ["Sources/**"],
        resources: ["Resources/**"],
        entitlements: "Support/\(env.appName).entitlements",
        scripts: scripts,
        dependencies: [
            .Projects.flow
        ],
        settings: .settings(base: env.baseSetting)
    )
]

let schemes: [Scheme] = [
    .scheme(
        name: "\(env.targetName)-Dev",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.targetName)"]),
        runAction: .runAction(configuration: .dev),
        archiveAction: .archiveAction(configuration: .dev),
        profileAction: .profileAction(configuration: .dev),
        analyzeAction: .analyzeAction(configuration: .dev)
    ),
    .scheme(
        name: "\(env.targetName)-PROD",
        shared: true,
        buildAction: .buildAction(targets: ["\(env.targetName)"]),
        runAction: .runAction(configuration: .prod),
        archiveAction: .archiveAction(configuration: .prod),
        profileAction: .profileAction(configuration: .prod),
        analyzeAction: .analyzeAction(configuration: .prod)
    )
]

let project = Project(
    name: env.targetName,
    organizationName: env.organizationName,
    packages: [],
    settings: settings,
    targets: targets,
    schemes: schemes
)
