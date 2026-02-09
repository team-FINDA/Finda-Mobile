import SwiftUI
import ComposableArchitecture

public struct AuthRootView: View {
    @Perception.Bindable private var store: StoreOf<AuthRootFeature>

    public init(store: StoreOf<AuthRootFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            let selectedRole = store.selectedRole
            NavigationStackStore(
                store.scope(state: \.path, action: \.path)
            ) {
                SigninUserSelectView(
                    store: store.scope(
                        state: \.signinUserSelect,
                        action: \.signinUserSelect
                    )
                )
            } destination: { store in
                switch store.state {
                case .signin:
                    IfLetStore(
                        store.scope(
                            state: \.signin,
                            action: \.signin
                        ),
                        then: SigninView.init
                    )
                case .signupUserSelect:
                    IfLetStore(
                        store.scope(
                            state: \.signupUserSelect,
                            action: \.signupUserSelect
                        ),
                        then: SignupUserSelectView.init
                    )
                case .signinUserSelect:
                    IfLetStore(
                        store.scope(
                            state: \.signinUserSelect,
                            action: \.signinUserSelect
                        ),
                        then: SigninUserSelectView.init
                    )
                case .secretKey:
                    IfLetStore(
                        store.scope(
                            state: \.secretKey,
                            action: \.secretKey
                        ),
                        then: { SecretKeyView(store: $0, selectedRole: selectedRole) }
                    )
                case .emailVerification:
                    IfLetStore(
                        store.scope(
                            state: \.emailVerification,
                            action: \.emailVerification
                        ),
                        then: { EmailVerificationView(store: $0, selectedRole: selectedRole) }
                    )
                case .infomation:
                    IfLetStore(
                        store.scope(
                            state: \.infomation,
                            action: \.infomation
                        ), then: { InfomationView(store: $0, selectedRole: selectedRole) }
                    )
                }
            }
        }
    }
}

#Preview {
    AuthRootView(
        store: Store(initialState: AuthRootFeature.State()) {
            AuthRootFeature()
        }
    )
}
