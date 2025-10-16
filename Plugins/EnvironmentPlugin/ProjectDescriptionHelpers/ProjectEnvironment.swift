import ProjectDescription

public struct ProjectEnvironment {
    public let appName: String
    public let targetName: String
    public let organizationName: String
    public let deploymentTargets: DeploymentTargets
    public let destination: Destinations
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    appName: "Finda-iOS",
    targetName: "Finda-iOS",
    organizationName: "com.finda.app",
    deploymentTargets: .iOS("16.0"),
    destination: .iOS,
    baseSetting: ["OTHER_LDFLAGS": ["$(inherited) -Objc"]]
)
