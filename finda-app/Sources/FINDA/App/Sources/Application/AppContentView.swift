#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

struct AppContentView: View {
    private let store: StoreOf<AppFeature>

    init(store: StoreOf<AppFeature> = StoreOf<AppFeature>(initialState: AppFeature.State()) { AppFeature() }) {
        self.store = store
    }

    var body: some View {
        AppView(store: store)
    }
}
#endif
