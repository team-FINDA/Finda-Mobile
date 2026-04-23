import SwiftUI
import ComposableArchitecture
import DesignSystem

struct ContentView: View {
    var body: some View {
        AppView(
            store: Store(initialState: AppFeature.State()) {
                AppFeature()
            }
        )
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.Gray.gray10.ignoresSafeArea())
    }
}
