import SwiftUI
import ComposableArchitecture

public struct MyRootView: View {
    @Perception.Bindable private var store: StoreOf<MyRootFeature>

    public init(store: StoreOf<MyRootFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            NavigationStackStore(
                store.scope(state: \.path, action: \.path)
            ) {
                MyView(
                    store: store.scope(
                        state: \.my,
                        action: \.my
                    )
                )
            } destination: { pathStore in
                switch pathStore.state {
                case .setting:
                    IfLetStore(
                        pathStore.scope(
                            state: \.setting,
                            action: \.setting
                        ),
                        then: SettingView.init
                    )

                case .volunteerHistory:
                    IfLetStore(
                        pathStore.scope(
                            state: \.volunteerHistory,
                            action: \.volunteerHistory
                        ),
                        then: VolunteerHistoryView.init
                    )

                case.alertSetting:
                    IfLetStore(
                        pathStore.scope(
                            state: \.alertSetting,
                            action: \.alertSetting
                        ),
                        then: AlertSettingView.init
                    )

                case .passwordChangeEmailVerification:
                    IfLetStore(
                        pathStore.scope(
                            state: \.passwordChangeEmailVerification,
                            action: \.passwordChangeEmailVerification
                        ),
                        then: { PasswordChangeEmailVerificationView(store: $0, selectedRole: nil) }
                    )

                case .newPassword:
                    IfLetStore(
                        pathStore.scope(
                            state: \.newPassword,
                            action: \.newPassword
                        ),
                        then: { NewPasswordView(store: $0, selectedRole: nil) }
                    )
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
