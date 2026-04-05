#if !SKIP
import ComposableArchitecture

@Reducer
public struct SigninUserSelectFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case signupButtonTapped
        case teacherSigninButtonTapped
        case studentSigninButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .signupButtonTapped:
                return .none
            case .teacherSigninButtonTapped:
                return .none
            case .studentSigninButtonTapped:
                return .none
            }
        }
    }
}

#endif
