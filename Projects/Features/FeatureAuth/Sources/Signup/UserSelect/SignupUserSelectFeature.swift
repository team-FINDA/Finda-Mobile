import ComposableArchitecture

@Reducer
public struct SignupUserSelectFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case backButtonTapped
        case studentSignupButtonTapped
        case teacherSignupButtonTapped
        case signinButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .backButtonTapped:
                return .none
            case .studentSignupButtonTapped:
                return .none
            case .teacherSignupButtonTapped:
                return .none
            case .signinButtonTapped:
                return .none
            }
        }
    }
}
