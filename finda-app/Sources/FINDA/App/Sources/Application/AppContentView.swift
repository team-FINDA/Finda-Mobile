import SwiftUI

#if !SKIP && canImport(UIKit)
import ComposableArchitecture

struct AppContentView: View {
    private let store: StoreOf<AppFeature>

    init() {
        self.store = Store(initialState: AppFeature.State()) {
            AppFeature()
        }
    }

    init(store: StoreOf<AppFeature>) {
        self.store = store
    }

    var body: some View {
        AppView(store: store)
    }
}
#else
struct AppContentView: View {
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            Text("QR")
                .tabItem { FINDAImage("tabbarQR") }
                .tag(0)

            Text("홈")
                .tabItem { FINDAImage("tabbarLogo") }
                .tag(1)

            Text("일정")
                .tabItem { FINDAImage("tabbarCalendar") }
                .tag(2)

            Text("마이")
                .tabItem { FINDAImage("tabbarPerson") }
                .tag(3)
        }
    }
}
#endif
