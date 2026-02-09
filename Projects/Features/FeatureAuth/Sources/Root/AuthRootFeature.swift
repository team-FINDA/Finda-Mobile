import ComposableArchitecture

@Reducer
public struct AuthRootFeature {
    @ObservableState
    public struct State: Equatable {
        var signinUserSelect = SigninUserSelectFeature.State()
        var path = StackState<Path.State>()

        public init() {}
    }

    public enum Action {
        case signinUserSelect(SigninUserSelectFeature.Action)
        case signupUserSelect(SignupUserSelectFeature.Action)
        case secretKey(SecretKeyFeature.Action)
        case path(StackActionOf<Path>)
    }

    @Reducer
    public enum Path {
        case signin(SigninFeature)
        case signinUserSelect(SigninUserSelectFeature)
        case signupUserSelect(SignupUserSelectFeature)
        case secretKey(SecretKeyFeature)
        case emailVerification(EmailVerificationFeature)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.signinUserSelect, action: \.signinUserSelect) {
            SigninUserSelectFeature()
        }
        Reduce { state, action in
            switch action {
            case .signinUserSelect(.signupButtonTapped):
                state.path.append(.signupUserSelect(SignupUserSelectFeature.State()))
                return .none

            case .signinUserSelect(.studentSigninButtonTapped):
                state.path.append(.signin(SigninFeature.State(role: .student)))
                return .none

            case .signinUserSelect(.teacherSigninButtonTapped):
                state.path.append(.signin(SigninFeature.State(role: .teacher)))
                return .none

            case .secretKey(.nextButtonTapped):
                state.path.append(.emailVerification(EmailVerificationFeature.State()))
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.teacherSignupButtonTapped))):
                state.path.append(.secretKey(SecretKeyFeature.State()))
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.signinButtonTapped))):
                _ = state.path.popLast()
                return .none

            case .path(.element(id: _, action: .secretKey(.nextButtonTapped))):
                state.path.append(.emailVerification(EmailVerificationFeature.State()))
                return .none

            case .signinUserSelect, .signupUserSelect, .secretKey:
                return .none

            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension AuthRootFeature.Path.State: Equatable {}
