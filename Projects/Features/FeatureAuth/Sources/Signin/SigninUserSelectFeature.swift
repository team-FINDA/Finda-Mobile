import Foundation
import ComposableArchitecture

@Reducer
public struct SigninUserSelectFeature {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case signupButtonTapped
    }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .signupButtonTapped:
                return .none
            }
        }
    }
}
