#if !SKIP && canImport(UIKit)
import ComposableArchitecture

@Reducer
public struct SecretKeyFeature {
    @ObservableState
    public struct State: Equatable {
        var secretKeyText = ""
        var signupButtonIsDisabled = true

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
                state.signupButtonIsDisabled = state.secretKeyText.isEmpty
                return .none
            case .nextButtonTapped:
                return .none
            case .signinButtonTapped:
                return .none
            }
        }
    }
}

#endif
