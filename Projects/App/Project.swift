import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "FINDA",
    product: .app,
    packages: [],
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "FeatureAuth", path: .relativeToRoot("Projects/Features/FeatureAuth")),
        .project(target: "FeatureStudent", path: .relativeToRoot("Projects/Features/FeatureStudent")),
        .project(target: "FeatureTeacher", path: .relativeToRoot("Projects/Features/FeatureTeacher")),
        .project(target: "FeatureSchedule", path: .relativeToRoot("Projects/Features/FeatureSchedule")),
        .project(target: "Core", path: .relativeToRoot("Projects/Core")),
        .project(target: "DesignSystem", path: .relativeToRoot("Projects/DesignSystem")),
    ]
)
