import ComposableArchitecture

@Reducer
public struct SignupUserSelectFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case signinButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signinButtonTapped:
                return .none
            }
        }
    }
}
