import ProjectDescription
import EnvironmentPlugin

public extension Project {
    static func makeModule(
        name: String,
        organizationName: String = env.organizationName,
        destinations: Destinations = env.destination,
        product: Product,
        packages: [Package] = [],
        deploymentTargets: DeploymentTargets = env.deploymentTargets,
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Project {
        
        let targets: [Target] = [
            .target(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: organizationName,
                deploymentTargets: deploymentTargets,
                infoPlist: .default,
                sources: sources,
                resources: resources,
                dependencies: dependencies
            ),
            .target(
                name: "\(name)Tests",
                destinations: destinations,
                product: .unitTests,
                bundleId: "\(organizationName).tests",
                deploymentTargets: deploymentTargets,
                infoPlist: .default,
                sources: ["Tests/**"],
                dependencies: [
                    .target(name: name)
                ]
            )
        ]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            targets: targets
        )
    }
}
