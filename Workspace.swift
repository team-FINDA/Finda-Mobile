import ProjectDescription
import EnvironmentPlugin

let workspace = Workspace(
    name: env.appName,
    projects: [
        "Projects/App",
        "Projects/Features/FeatureAuth",
        "Projects/Features/FeatureStudent",
        "Projects/Features/FeatureTeacher",
        "Projects/Features/FeatureSchedule",
        "Projects/Core",
        "Projects/DesignSystem",
        "Projects/Shared"
    ]
)
