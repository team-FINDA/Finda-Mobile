import ProjectDescription

let project = Project(
    name: "Finda-iOS",
    targets: [
        .target(
            name: "Finda-iOS",
            destinations: .iOS,
            product: .app,
            bundleId: "io.tuist.Finda-iOS",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["Finda-iOS/Sources/**"],
            resources: ["Finda-iOS/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "Finda-iOSTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.Finda-iOSTests",
            infoPlist: .default,
            sources: ["Finda-iOS/Tests/**"],
            resources: [],
            dependencies: [.target(name: "Finda-iOS")]
        ),
    ]
)
