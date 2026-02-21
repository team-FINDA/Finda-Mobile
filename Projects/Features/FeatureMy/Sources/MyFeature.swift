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
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            }
        }
    }
}
