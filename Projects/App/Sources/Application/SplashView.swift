import SwiftUI
import DesignSystem

struct SplashView: View {
    var body: some View {
        Image(uiImage: FINDAAsset.splashLogo.image)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.Gray.gray10.ignoresSafeArea())
    }
}

#Preview {
    SplashView()
}
