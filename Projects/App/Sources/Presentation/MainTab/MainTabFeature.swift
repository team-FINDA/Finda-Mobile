import ComposableArchitecture
import FeatureStudent
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

        init(role: UserRole) {
            self.role = role
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case studentMain(StudentMainFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {
        Scope(state: \.studentMain, action: \.studentMain) {
            StudentMainFeature()
        }

        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .studentMain:
                return .none
            }
        }
    }
}
