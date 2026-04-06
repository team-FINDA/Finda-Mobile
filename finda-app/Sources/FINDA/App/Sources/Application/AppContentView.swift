#if !SKIP && canImport(UIKit)
import SwiftUI
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
#endif
