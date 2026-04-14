import SwiftUI

enum Tab: Hashable {
    case QRCode
    case main
    case schedule
    case profile
}

@Observable
final class MainTabViewModel {
    let role: UserRole
    var selectedTab: Tab = .main

    init(role: UserRole) {
        self.role = role
    }
}

struct MainTabView: View {
    @State private var viewModel: MainTabViewModel

    init(role: UserRole) {
        _viewModel = State(initialValue: MainTabViewModel(role: role))
    }

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            QRTabView(role: viewModel.role)
                .tabItem {
                    Image(viewModel.selectedTab == .QRCode ? "tabbarQR" : "tabbarQRNot")
                }
                .tag(Tab.QRCode)

            HomeTabView(role: viewModel.role)
                .tabItem {
                    Image(viewModel.selectedTab == .main ? "tabbarLogo" : "tabbarLogoNot")
                }
                .tag(Tab.main)

            ScheduleTabView(role: viewModel.role)
                .tabItem {
                    Image(viewModel.selectedTab == .schedule ? "tabbarCalendar" : "tabbarCalendarNot")
                }
                .tag(Tab.schedule)

            ProfileTabView(role: viewModel.role)
                .tabItem {
                    Image(viewModel.selectedTab == .profile ? "tabbarPerson" : "tabbarPersonNot")
                }
                .tag(Tab.profile)
        }
    }
}

private struct QRTabView: View {
    let role: UserRole

    var body: some View {
        switch role {
        case .student:
            QRScanView()
        case .teacher:
            QRCreateView()
        }
    }
}

private struct HomeTabView: View {
    let role: UserRole

    var body: some View {
        switch role {
        case .student:
            StudentMainView()
        case .teacher:
            TeacherMainView()
        }
    }
}

private struct ScheduleTabView: View {
    let role: UserRole

    var body: some View {
        ScheduleView()
    }
}

private struct ProfileTabView: View {
    let role: UserRole

    var body: some View {
        MyRootView(role: role)
    }
}

#Preview {
    MainTabView(role: .student)
}
