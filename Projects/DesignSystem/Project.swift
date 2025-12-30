import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "DesignSystem",
    product: .framework,
    resources: ["Resources/**"],
    dependencies: [
        .project(target: "Shared", path: .relativeToRoot("Projects/Shared"))
    ]
)
