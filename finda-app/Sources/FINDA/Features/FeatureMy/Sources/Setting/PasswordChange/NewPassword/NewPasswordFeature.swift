#if !SKIP && canImport(UIKit)
import ComposableArchitecture

@Reducer
public struct NewPasswordFeature {
    @ObservableState
    public struct State: Equatable {
        var passwordText: String = ""
        var passwordConfirmText: String = ""
        var passwordChangeButtonIsDisabled = true

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case passwordChangeButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                state.passwordChangeButtonIsDisabled =
                    state.passwordText.isEmpty ||
                    state.passwordConfirmText.isEmpty ||
                    state.passwordText != state.passwordConfirmText
                return .none

            case .passwordChangeButtonTapped:
                return .none
            }
        }
    }
}

#endif
