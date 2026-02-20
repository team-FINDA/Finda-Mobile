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
        .Features.featureAuth,
        .Features.featureStudent,
        .Features.featureTeacher,
        .Features.featureSchedule,
        .Features.featureMy,
        .Projects.core,
        .Projects.designSystem,
        .tca
    ],
    additionalPlistRows: [
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
        "UILaunchScreen": [:],
        "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
        "NSCameraUsageDescription": "QR 코드를 스캔하기 위해 카메라 접근이 필요합니다.",
        "API_BASE_URL": "$(API_BASE_URL)"
    ]
)
