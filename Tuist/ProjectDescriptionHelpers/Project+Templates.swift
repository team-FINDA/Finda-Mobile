import ProjectDescription

public extension Project {
    static func makeModule(
        name: String,
        organizationName: String = "com.finda",
        destinations: Destinations = .iOS,
        product: Product,
        packages: [Package] = [],
        deploymentTargets: DeploymentTargets = .iOS("16.0"),
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        dependencies: [TargetDependency] = []
    ) -> Project {
        
        let targets: [Target] = [
            .target(
                name: name,
                destinations: destinations,
                product: product,
                bundleId: "\(organizationName).\(name.lowercased())",
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
                bundleId: "\(organizationName).\(name.lowercased()).tests",
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
