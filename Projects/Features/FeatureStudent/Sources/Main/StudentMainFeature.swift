import ComposableArchitecture

@Reducer
public struct StudentMainFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case notificationButtonTapped
        case shortNotificationButtonTapped
        case volunteerFindButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .notificationButtonTapped:
                return .none
            case .shortNotificationButtonTapped:
                return .none
            case .volunteerFindButtonTapped:
                return .none
            }
        }
    }
}
