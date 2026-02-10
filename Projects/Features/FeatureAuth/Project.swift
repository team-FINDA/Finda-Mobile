import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: "FeatureAuth",
    product: .framework,
    packages: [],
    dependencies: [
        .Projects.core,
        .Projects.shared,
        .Projects.designSystem,
        .tca
    ]
)
