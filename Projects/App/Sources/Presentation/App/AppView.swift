import SwiftUI
import ComposableArchitecture
import FeatureAuth
import DesignSystem

struct AppView: View {
    private let store: StoreOf<AppFeature>

    init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            ZStack {
                Group {
                    if let store = store.scope(
                        state: \.mainTab,
                        action: \.mainTab
                    ) {
                        MainTabView(store: store)
                            .transition(.opacity)
                    } else {
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.Gray.gray10.ignoresSafeArea())
            .onAppear {
                store.send(.onAppear)
            }
            .animation(.easeInOut(duration: 0.3), value: store.isShowingSplash)
            .animation(.easeInOut(duration: 0.35), value: store.mainTab != nil)
        }
    }
}
