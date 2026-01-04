import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "DesignSystem",
    resources: ["Resources/**"],
    product: .framework,
    dependencies: [
        .Projects.shared
    ]
)
