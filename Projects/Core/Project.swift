import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "Core",
    product: .framework,
    packages: [],
    dependencies: [
        .Projects.shared
    ]
)
