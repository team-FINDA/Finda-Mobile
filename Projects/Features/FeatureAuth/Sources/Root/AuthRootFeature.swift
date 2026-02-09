import ComposableArchitecture

@Reducer
public struct AuthRootFeature {
    @ObservableState
    public struct State: Equatable {
        var signinUserSelect = SigninUserSelectFeature.State()
        var path = StackState<Path.State>()
        var selectedRole: SigninUserType?

        public init() {}
    }

    public enum Action {
        case signinUserSelect(SigninUserSelectFeature.Action)
        case signupUserSelect(SignupUserSelectFeature.Action)
        case secretKey(SecretKeyFeature.Action)
        case emailVerification(EmailVerificationFeature.Action)
        case path(StackActionOf<Path>)
    }

    @Reducer
    public enum Path {
        case signin(SigninFeature)
        case signinUserSelect(SigninUserSelectFeature)
        case signupUserSelect(SignupUserSelectFeature)
        case secretKey(SecretKeyFeature)
        case emailVerification(EmailVerificationFeature)
        case infomation(InfomationFeature)
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
                state.selectedRole = .student
                state.path.append(.signin(SigninFeature.State(role: .student)))
                return .none

            case .signinUserSelect(.teacherSigninButtonTapped):
                state.selectedRole = .teacher
                state.path.append(.signin(SigninFeature.State(role: .teacher)))
                return .none

            case .secretKey(.nextButtonTapped):
                state.path.append(.emailVerification(EmailVerificationFeature.State()))
                return .none

            case .emailVerification(.nextButtonTapped):
                state.path.append(.infomation(InfomationFeature.State()))
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.studentSignupButtonTapped))):
                state.selectedRole = .student
                state.path.append(.emailVerification(EmailVerificationFeature.State()))
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.teacherSignupButtonTapped))):
                state.selectedRole = .teacher
                state.path.append(.secretKey(SecretKeyFeature.State()))
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.signinButtonTapped))):
                _ = state.path.popLast()
                return .none

            case .path(.element(id: _, action: .secretKey(.nextButtonTapped))):
                state.path.append(.emailVerification(EmailVerificationFeature.State()))
                return .none

            case .path(.element(id: _, action: .emailVerification(.nextButtonTapped))):
                state.path.append(.infomation(InfomationFeature.State()))
                return .none

            case .signinUserSelect, .signupUserSelect, .secretKey, .emailVerification:
                return .none

            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension AuthRootFeature.Path.State: Equatable {}
