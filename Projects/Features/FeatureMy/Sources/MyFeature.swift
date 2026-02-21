import ComposableArchitecture
import Shared

@Reducer
public struct MyFeature {
    @ObservableState
    public struct State: Equatable {
        var role: UserRole
        var path = StackState<Path.State>()

        public init(role: UserRole) {
            self.role = role
        }
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case volunteerHistoryButtonTapped
        case path(StackActionOf<Path>)
    }

    @Reducer
    public enum Path {
        case volunteerHistory(VolunteerHistoryFeature)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .volunteerHistoryButtonTapped:
                guard state.role == .student else { return .none }
                state.path.append(.volunteerHistory(VolunteerHistoryFeature.State()))
                return .none

            case .binding:
                return .none

            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension MyFeature.Path.State: Equatable {}
