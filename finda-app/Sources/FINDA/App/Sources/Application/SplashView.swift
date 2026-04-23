import SwiftUI

struct SplashView: View {
    var body: some View {
        FINDAImage("splashLogo")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray10.ignoresSafeArea())
    }
}

#Preview {
    SplashView()
}
