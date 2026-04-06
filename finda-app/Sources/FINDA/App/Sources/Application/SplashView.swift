#if !SKIP && canImport(UIKit)
import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("splashLogo")
    }
}

#Preview {
    SplashView()
}
#endif
