import SwiftUI
import ComposableArchitecture
import FeatureAuth

struct AppView: View {
    private let store: StoreOf<AppFeature>

    init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    var body: some View {
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
