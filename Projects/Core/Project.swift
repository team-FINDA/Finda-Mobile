import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeModule(
    name: "Core",
    product: .framework,
    packages: [],
    dependencies: [
        .project(target: "Shared", path: .relativeToRoot("Projects/Shared")),
    ]
)
