#if !SKIP
import ComposableArchitecture

@Reducer
public struct StudentMainFeature {
    @ObservableState
    public struct State: Equatable {
        var path = StackState<Path.State>()
        public init() {}
    }

    public enum Action {
        case notificationButtonTapped
        case shortNotificationButtonTapped
        case volunteerFindButtonTapped
        case path(StackActionOf<Path>)
    }

    @Reducer
    public enum Path {
        case volunteerList(VolunteerListFeature)
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
                state.path.append(.volunteerList(VolunteerListFeature.State()))
                return .none
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension StudentMainFeature.Path.State: Equatable {}

#endif
