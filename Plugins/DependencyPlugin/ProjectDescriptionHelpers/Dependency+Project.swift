import ProjectDescription

public extension TargetDependency {
    struct Projects {}
    struct Features {}
}

public extension TargetDependency.Projects {
    static let core = project(name: "Core")
    static let designSystem = project(name: "DesignSystem")
    static let shared = project(name: "Shared")

    static func project(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/\(name)")
        )
    }
}

public extension TargetDependency.Features {
    static let featureAuth = feature(name: "FeatureAuth")
    static let featureSchedule = feature(name: "FeatureSchedule")
    static let featureStudent = feature(name: "FeatureStudent")
    static let featureTeacher = feature(name: "FeatureTeacher")

    static func feature(name: String) -> TargetDependency {
        return .project(
            target: name,
            path: .relativeToRoot("Projects/Features/\(name)")
        )
    }
}
