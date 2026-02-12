import ComposableArchitecture
import FeatureStudent
import FeatureTeacher
import Shared

enum Tab: Hashable {
    case qr
    case main
    case schedule
    case profile
}

@Reducer
struct MainTabFeature {
    @ObservableState
    struct State: Equatable {
        var role: UserRole
        var selectedTab: Tab = .main
        var studentMain = StudentMainFeature.State()
        var teacherMain = TeacherMainFeature.State()

        init(role: UserRole) {
            self.role = role
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case studentMain(StudentMainFeature.Action)
        case teacherMain(TeacherMainFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {
        Scope(state: \.studentMain, action: \.studentMain) {
            StudentMainFeature()
        }
        Scope(state: \.teacherMain, action: \.teacherMain) {
            TeacherMainFeature()
        }

        BindingReducer()
        Reduce { _, action in
            switch action {
            case .binding:
                return .none

            case .studentMain:
                return .none

            case .teacherMain:
                return .none
            }
        }
    }
}
