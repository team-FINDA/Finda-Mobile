import ComposableArchitecture
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

        init(role: UserRole) {
            self.role = role
        }
    }

    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    init() {}

    var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            }
        }
    }
}
