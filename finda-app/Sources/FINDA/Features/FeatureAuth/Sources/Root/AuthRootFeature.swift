#if !SKIP
import ComposableArchitecture
import Shared

@Reducer
public struct AuthRootFeature {
    @ObservableState
    public struct State: Equatable {
        var signinUserSelect = SigninUserSelectFeature.State()
        var path = StackState<Path.State>()
        public var selectedRole: UserRole?

        public init() {}
    }

    public enum Action {
        case signinUserSelect(SigninUserSelectFeature.Action)
        case path(StackActionOf<Path>)
    }

    @Reducer
    public enum Path {
        case signin(SigninFeature)
        case signupUserSelect(SignupUserSelectFeature)
        case secretKey(SecretKeyFeature)
        case emailVerification(EmailVerificationFeature)
        case information(InformationFeature)
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

            case .path(.element(id: _, action: .signupUserSelect(.studentSignupButtonTapped))):
                state.selectedRole = .student
                state.path.append(.emailVerification(EmailVerificationFeature.State()))
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.teacherSignupButtonTapped))):
                state.selectedRole = .teacher
                state.path.append(.secretKey(SecretKeyFeature.State()))
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.backButtonTapped))):
                state.selectedRole = nil
                state.path = StackState()
                return .none

            case .path(.element(id: _, action: .signupUserSelect(.signinButtonTapped))):
                state.path.append(.signupUserSelect(SignupUserSelectFeature.State()))
                return .none

            case .path(.element(id: _, action: .signin(.signupButtonTapped))):
                state.selectedRole = nil
                state.path.append(.signupUserSelect(SignupUserSelectFeature.State()))
                return .none

            case .path(.element(id: _, action: .secretKey(.signinButtonTapped))):
                state.selectedRole = nil
                state.path = StackState()
                return .none

            case .path(.element(id: _, action: .emailVerification(.signinButtonTapped))):
                state.selectedRole = nil
                state.path = StackState()
                return .none

            case .path(.element(id: _, action: .information(.signinButtonTapped))):
                state.selectedRole = nil
                state.path = StackState()
                return .none

            case .path(.element(id: _, action: .secretKey(.nextButtonTapped))):
                state.path.append(.emailVerification(EmailVerificationFeature.State()))
                return .none

            case .path(.element(id: _, action: .emailVerification(.nextButtonTapped))):
                state.path.append(.information(InformationFeature.State()))
                return .none

            case .signinUserSelect:
                return .none

            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension AuthRootFeature.Path.State: Equatable {}

#endif
