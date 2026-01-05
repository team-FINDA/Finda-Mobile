import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "FINDA",
    resources: ["Resources/**"],
    product: .app,
    packages: [],
    dependencies: [
        .Projects.shared,
        .Features.featureStudent,
        .Features.featureTeacher,
        .Features.featureSchedule,
        .Projects.core,
        .Projects.designSystem
    ],
    additionalPlistRows: [
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
        "UILaunchScreen": [:],
        "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
        "API_BASE_URL": "$(API_BASE_URL)"
    ]
)
