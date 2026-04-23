import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct AuthRootView: View {
    @Perception.Bindable private var store: StoreOf<AuthRootFeature>

    public init(store: StoreOf<AuthRootFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            let selectedRole = store.selectedRole
            NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
                SigninUserSelectView(
                    store: store.scope(
                        state: \.signinUserSelect,
                        action: \.signinUserSelect
                    )
                )
            } destination: { store in
                switch store.case {
                case .signin(let store):
                    SigninView(store: store)
                case .signupUserSelect(let store):
                    SignupUserSelectView(store: store)
                case .secretKey(let store):
                    SecretKeyView(store: store, selectedRole: selectedRole)
                case .emailVerification(let store):
                    EmailVerificationView(store: store, selectedRole: selectedRole)
                case .information(let store):
                    InformationView(store: store, selectedRole: selectedRole)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.Gray.gray10.ignoresSafeArea())
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
