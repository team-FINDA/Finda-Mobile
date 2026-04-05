#if !SKIP
import ComposableArchitecture

@Reducer
public struct PasswordChangeEmailVerificationFeature {
    @ObservableState
    public struct State: Equatable {
        var emailText = ""
        var codeText = ""
        var nextButtonIsDisabled = true

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case nextButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.nextButtonIsDisabled = state.emailText.isEmpty || state.codeText.isEmpty
                return .none
            case .nextButtonTapped:
                return .none
            }
        }
    }
}

#endif
