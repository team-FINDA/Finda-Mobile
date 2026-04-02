import ComposableArchitecture
import FeatureMy
import FeatureStudent
import FeatureTeacher
import Shared

enum Tab: Hashable {
    case QRCode
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
        var myPage: MyRootFeature.State

        init(role: UserRole) {
            self.role = role
            self.myPage = MyRootFeature.State(role: role)
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case studentMain(StudentMainFeature.Action)
        case teacherMain(TeacherMainFeature.Action)
        case myPage(MyRootFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {
        Scope(state: \.studentMain, action: \.studentMain) {
            StudentMainFeature()
        }
        Scope(state: \.teacherMain, action: \.teacherMain) {
            TeacherMainFeature()
        }
        Scope(state: \.myPage, action: \.myPage) {
            MyRootFeature()
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

            case .myPage:
                return .none
            }
        }
    }
}
