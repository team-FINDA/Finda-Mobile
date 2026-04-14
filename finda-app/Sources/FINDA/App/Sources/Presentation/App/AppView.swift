import SwiftUI

@Observable
final class AppViewModel {
    var isShowingSplash = true
    var role: UserRole?

    func splashFinished() {
        isShowingSplash = false
    }

    func didAuthenticate(role: UserRole) {
        self.role = role
    }
}

struct AppView: View {
    @State private var viewModel = AppViewModel()

    var body: some View {
        ZStack {
            Group {
                if let role = viewModel.role {
                    MainTabView(role: role)
                } else {
                    AuthRootView { role in
                        viewModel.didAuthenticate(role: role)
                    }
                }
            }
            .opacity(viewModel.isShowingSplash ? 0.0 : 1.0)
            if viewModel.isShowingSplash {
                SplashView()
                    .zIndex(1)
            }
        }
        .task {
            guard viewModel.isShowingSplash else { return }
            try? await Task.sleep(for: .seconds(1.2))
            await MainActor.run {
                viewModel.splashFinished()
            }
        }
    }
}
