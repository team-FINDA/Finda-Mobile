import ComposableArchitecture
import Shared

@Reducer
public struct VolunteerHistoryFeature {
    @ObservableState
    public struct State: Equatable {

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { _, action in
            switch action {
            case .binding:
                return .none
            }
        }
    }
}
