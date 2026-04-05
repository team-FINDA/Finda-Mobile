#if !SKIP
import ComposableArchitecture
import Shared

@Reducer
public struct SigninFeature {
    @ObservableState
    public struct State: Equatable {
        var role: UserRole
        var emailText = ""
        var passwordText = ""
        var signinButtonIsDisabled = true

        public init(role: UserRole) {
            self.role = role
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case signinButtonTapped
        case signupButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.signinButtonIsDisabled = state.emailText.isEmpty || state.passwordText.isEmpty
                return .none

            case .signinButtonTapped:
                return .none

            case .signupButtonTapped:
                return .none
            }
        }
    }
}

#endif
