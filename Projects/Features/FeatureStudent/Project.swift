import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "FeatureStudent",
    product: .framework,
    packages: [],
    dependencies: [
        .Projects.core,
        .Projects.designSystem
    ]
)
