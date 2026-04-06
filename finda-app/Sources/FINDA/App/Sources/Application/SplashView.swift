#if !SKIP && canImport(UIKit)
import SwiftUI

struct SplashView: View {
    var body: some View {
        Image(uiImage: FINDAAsset.splashLogo.image)
    }
}

#Preview {
    SplashView()
}
#endif
