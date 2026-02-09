import ComposableArchitecture

@Reducer
public struct InfomationFeature {
    @ObservableState
    public struct State: Equatable {
        var nameText: String = ""
        var passwordText: String = ""
        var passwordConfirmText: String = ""
        var signupButtonIsDisable = true

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case signupButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.signupButtonIsDisable = state.nameText.isEmpty || state.passwordText.isEmpty || state.passwordConfirmText.isEmpty
                return .none
            case .signupButtonTapped:
                return .none
            }
        }
    }
}
