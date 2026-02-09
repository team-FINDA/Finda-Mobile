import ComposableArchitecture

@Reducer
public struct InformationFeature {
    @ObservableState
    public struct State: Equatable {
        var nameText: String = ""
        var passwordText: String = ""
        var passwordConfirmText: String = ""
        var signupButtonIsDisabled = true

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case signupButtonTapped
        case signinButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.signupButtonIsDisabled =
                    state.nameText.isEmpty ||
                    state.passwordText.isEmpty ||
                    state.passwordText.isEmpty != state.passwordConfirmText.isEmpty
                return .none
            case .signupButtonTapped:
                return .none
            case .signinButtonTapped:
                return .none
            }
        }
    }
}
