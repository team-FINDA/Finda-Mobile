#if !SKIP
import ComposableArchitecture
import Shared

@Reducer
public struct MyFeature {
    @ObservableState
    public struct State: Equatable {
        var role: UserRole

        public init(role: UserRole) {
            self.role = role
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case settingButtonTapped
        case myButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { _, action in
            switch action {
            case .settingButtonTapped:
                return .none

            case .myButtonTapped:
                return .none

            case .binding:
                return .none
            }
        }
    }
}

#endif
