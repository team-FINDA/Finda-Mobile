import ComposableArchitecture

@Reducer
public struct SigninUserSelectFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case signupButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signupButtonTapped:
                return .none
            }
        }
    }
}
