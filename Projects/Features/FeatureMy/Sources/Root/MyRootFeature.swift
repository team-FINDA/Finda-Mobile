import ComposableArchitecture
import Shared

@Reducer
public struct MyRootFeature {
    @ObservableState
    public struct State: Equatable {
        var role: UserRole
        var my: MyFeature.State
        var path = StackState<Path.State>()

        public init(role: UserRole) {
            self.role = role
            self.my = MyFeature.State(role: role)
        }
    }

    public enum Action {
        case my(MyFeature.Action)
        case path(StackActionOf<Path>)
    }

    @Reducer
    public enum Path {
        case setting(SettingFeature)
        case volunteerHistory(VolunteerHistoryFeature)
        case alertSetting(AlertSettingFeature)
        case passwordChangeEmailVerification(PasswordChangeEmailVerificationFeature)
        case newPassword(NewPasswordFeature)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.my, action: \.my) {
            MyFeature()
        }
        Reduce { state, action in
            switch action {
            case .my(.settingButtonTapped):
                state.path.append(.setting(SettingFeature.State()))
                return .none

            case .my(.volunteerHistoryButtonTapped):
                guard state.role == .student else { return .none }
                state.path.append(.volunteerHistory(VolunteerHistoryFeature.State()))
                return .none

            case .path(.element(id: _, action: .setting(.alertSettingButtonTapped))):
                state.path.append(.alertSetting(AlertSettingFeature.State()))
                return .none

            case .path(.element(id: _, action: .setting(.passwordChangeButtonTapped))):
                state.path.append(.passwordChangeEmailVerification(PasswordChangeEmailVerificationFeature.State()))
                return .none

            case .path(.element(id: _, action: .passwordChangeEmailVerification(.nextButtonTapped))):
                state.path.append(.newPassword(NewPasswordFeature.State()))
                return .none

            case .path(.element(id: _, action: .newPassword(.passwordChangeButtonTapped))):
                state.path = StackState()
                return .none

            case .path:
                return .none

            case .my:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension MyRootFeature.Path.State: Equatable {}
