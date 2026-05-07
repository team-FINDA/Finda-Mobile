import SwiftUI

struct AppContentView: View {
    var body: some View {
        AppView()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.gray10.ignoresSafeArea())
    }
}
