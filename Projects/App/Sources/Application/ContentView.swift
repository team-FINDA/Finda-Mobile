import SwiftUI
import FeatureAuth

struct ContentView: View {
    @State private var isLaunch: Bool = true
    var body: some View {
        if isLaunch {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.linear) {
                            self.isLaunch = false
                        }
                    }
                }
        } else {
            SigninUserSelectView()
        }
    }
}
