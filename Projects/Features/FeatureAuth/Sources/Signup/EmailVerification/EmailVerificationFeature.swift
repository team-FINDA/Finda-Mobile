import ComposableArchitecture

@Reducer
public struct EmailVerificationFeature {
    @ObservableState
    public struct State: Equatable {
        var emailText = ""
        var codeText = ""
        var nextButtonIsDisable = true

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextButtonTapped
        case signinButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.nextButtonIsDisable = state.emailText.isEmpty || state.codeText.isEmpty
                return .none
            case .nextButtonTapped:
                return .none
            case.signinButtonTapped:
                return .none
            }
        }
    }
}
