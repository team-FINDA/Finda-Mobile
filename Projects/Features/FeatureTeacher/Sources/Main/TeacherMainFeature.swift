import ComposableArchitecture

@Reducer
public struct TeacherMainFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case notificationButtonTapped
        case shortnotificationButtonTapped
        case changeButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .notificationButtonTapped:
                return .none
            case .shortnotificationButtonTapped:
                return .none
            case .changeButtonTapped:
                return .none
            }
        }
    }
}
