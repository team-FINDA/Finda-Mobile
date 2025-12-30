import ProjectDescription

let project = Project(
    name: "FINDA",
    organizationName: "FINDA",
    targets: [
        .target(
            name: "FINDA",
            destinations: .iOS,
            product: .app,
            bundleId: "$(APP_BUNDLE_ID)",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(with: [
                "UILaunchScreen": [:],
                "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
                "CFBundleDisplayName": "FINDA"
            ]),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "FeatureAuth", path: .relativeToRoot("Projects/Features/FeatureAuth")),
                .project(target: "FeatureStudent", path: .relativeToRoot("Projects/Features/FeatureStudent")),
                .project(target: "FeatureTeacher", path: .relativeToRoot("Projects/Features/FeatureTeacher")),
                .project(target: "FeatureSchedule", path: .relativeToRoot("Projects/Features/FeatureSchedule")),
                .project(target: "Core", path: .relativeToRoot("Projects/Core")),
                .project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem")),
                .external(name: "ComposableArchitecture")
            ]
        )
    ]
)
