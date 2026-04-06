#if !SKIP && canImport(UIKit)
import SwiftUI

struct SplashView: View {
    var body: some View {
        FINDAImage("splashLogo")
    }
}

#Preview {
    SplashView()
}
#endif
