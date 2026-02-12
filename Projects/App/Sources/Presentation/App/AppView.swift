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
                Group {
                    IfLetStore(
                        store.scope(
                            state: \.mainTab,
                            action: \.mainTab
                        )
                    ) {
                        MainTabView(store: $0)
                            .transition(.opacity)
                    } else: {
                        AuthRootView(
                            store: store.scope(
                                state: \.authRoot,
                                action: \.authRoot
                            )
                        )
                        .transition(.opacity)
                    }
                }
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
            .animation(.easeInOut(duration: 0.35), value: store.mainTab != nil)
        }
    }
}
