#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

public struct MyRootView: View {
    @Bindable private var store: StoreOf<MyRootFeature>

    public init(store: StoreOf<MyRootFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            let selectedRole = store.role

            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                MyView(
                    store: store.scope(
                        state: \.myPage,
                        action: \.myPage
                    )
                )
            } destination: { pathStore in
                switch pathStore.case {
                case .setting(let store):
                    SettingView(store: store)

                case .volunteerHistory(let store):
                    VolunteerHistoryView(store: store)

                case .noticeManage(let store):
                    NoticeManageView(store: store)

                case .noticeDetail(let store):
                    NoticeDetailView(mode: store.mode)

                case .alertSetting(let store):
                    AlertSettingView(store: store)

                case .passwordChangeEmailVerification(let store):
                    PasswordChangeEmailVerificationView(store: store, selectedRole: selectedRole)

                case .newPassword(let store):
                    NewPasswordView(store: store, selectedRole: selectedRole)
                }
            }
        }
    }
}

#Preview {
    MyRootView(
        store: Store(initialState: MyRootFeature.State(role: .student)) {
            MyRootFeature()
        }
    )
}

#endif
