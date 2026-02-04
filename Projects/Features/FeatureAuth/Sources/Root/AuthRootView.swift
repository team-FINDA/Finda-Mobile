import SwiftUI
import ComposableArchitecture
import Foundation

public struct AuthRootView: View {
    @Perception.Bindable var store: StoreOf<AuthRootFeature>

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
                SwitchStore(store) { initialState in
                    CaseLet(
                        /AuthRootFeature.Path.State.signupUserSelect,
                        action: AuthRootFeature.Path.Action.signupUserSelect,
                        then: SignupUserSelectView.init
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
