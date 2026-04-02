import ComposableArchitecture
import Shared

@Reducer
public struct MyRootFeature {
    @ObservableState
    public struct State: Equatable {
        var role: UserRole
        var myPage: MyFeature.State
        var path = StackState<Path.State>()

        public init(role: UserRole) {
            self.role = role
            self.myPage = MyFeature.State(role: role)
        }
    }

    public enum Action {
        case myPage(MyFeature.Action)
        case path(StackActionOf<Path>)
    }

    @Reducer
    public enum Path {
        case setting(SettingFeature)
        case volunteerHistory(VolunteerHistoryFeature)
        case noticeManage(NoticeManageFeature)
        case noticeDetail(NoticeDetailFeature)
        case alertSetting(AlertSettingFeature)
        case passwordChangeEmailVerification(PasswordChangeEmailVerificationFeature)
        case newPassword(NewPasswordFeature)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Scope(state: \.myPage, action: \.myPage) {
            MyFeature()
        }
        Reduce { state, action in
            switch action {
            case .myPage(.settingButtonTapped):
                state.path.append(.setting(SettingFeature.State()))
                return .none

            case .myPage(.myButtonTapped):
                if state.role == .student {
                    state.path.append(.volunteerHistory(VolunteerHistoryFeature.State()))
                } else {
                    state.path.append(.noticeManage(NoticeManageFeature.State()))
                }
                return .none

            case .path(.element(id: _, action: .setting(.alertSettingButtonTapped))):
                state.path.append(.alertSetting(AlertSettingFeature.State()))
                return .none

            case .path(.element(id: _, action: .noticeManage(.addButtonTapped))):
                state.path.append(.noticeDetail(NoticeDetailFeature.State(mode: .create)))
                return .none

            case let .path(.element(id: _, action: .noticeManage(.noticeItemTapped(item)))):
                state.path.append(
                    .noticeDetail(
                        NoticeDetailFeature.State(
                            mode: .edit(
                                .init(
                                    title: item.title,
                                    content: item.content,
                                    date: item.date,
                                    time: item.time
                                )
                            )
                        )
                    )
                )
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

            case .myPage:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension MyRootFeature.Path.State: Equatable {}
