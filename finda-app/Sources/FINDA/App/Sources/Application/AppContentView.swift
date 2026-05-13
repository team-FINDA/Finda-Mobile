import SwiftUI

struct AppContentView: View {
    var body: some View {
        AppView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray10.ignoresSafeArea())
    }
}
