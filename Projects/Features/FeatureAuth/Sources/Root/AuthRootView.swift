import SwiftUI
import ComposableArchitecture

public struct AuthRootView: View {
    @Perception.Bindable private var store: StoreOf<AuthRootFeature>

    public init(store: StoreOf<AuthRootFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
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
                        then: SecretKeyView.init
                    )
                case .emailVerification:
                    IfLetStore(
                        store.scope(
                            state: \.emailVerification,
                            action: \.emailVerification
                        ),
                        then: EmailVerificationView.init
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
