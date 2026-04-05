#if !SKIP
import ComposableArchitecture

@Reducer
public struct TeacherMainFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {
        case notificationButtonTapped
        case shortNotificationButtonTapped
        case changeButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .notificationButtonTapped:
                return .none
            case .shortNotificationButtonTapped:
                return .none
            case .changeButtonTapped:
                return .none
            }
        }
    }
}

#endif
