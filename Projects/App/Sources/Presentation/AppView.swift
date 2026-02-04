import SwiftUI
import ComposableArchitecture
import FeatureAuth

public struct AppView: View {
    var store: StoreOf<AppFeature>

    public init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                AuthRootView(
                    store: store.scope(
                        state: \.authRoot,
                        action: \.authRoot
                    )
                )
                .opacity(store.isShowingSplash ? 0 : 1)

                if store.isShowingSplash {
                    SplashView()
                        .transition(.opacity)
                        .zIndex(1)
                }
            }
            .onAppear {
                store.send(.onAppear)
            }
            .animation(.easeInOut(duration: 0.3), value: store.isShowingSplash)
        }
    }
}
