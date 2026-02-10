import SwiftUI
import ComposableArchitecture
import FeatureMy
import FeatureSchedule
import FeatureStudent
import FeatureTeacher
import Shared

struct MainTabView: View {
    @Perception.Bindable private var store: StoreOf<MainTabFeature>

    init(store: StoreOf<MainTabFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            TabView(selection: $store.selectedTab) {
                QRTabView(role: store.role)
                    .tabItem {
                        Image(store.selectedTab == .qr ? "tabbarQR" : "tabbarQRNot")
                    }
                    .tag(Tab.qr)

                HomeTabView(role: store.role)
                    .tabItem {
                        Image(store.selectedTab == .main ? "tabbarLogo" : "tabbarLogoNot")
                    }
                    .tag(Tab.main)

                ScheduleTabView(role: store.role)
                    .tabItem {
                        Image(store.selectedTab == .schedule ? "tabbarCalendar" : "tabbarCalendarNot")
                    }
                    .tag(Tab.schedule)

                ProfileTabView(role: store.role)
                    .tabItem {
                        Image(store.selectedTab == .profile ? "tabbarPerson" : "tabbarPersonNot")
                    }
                    .tag(Tab.profile)
            }
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
        MyView()
    }
}

#Preview {
    MainTabView(
        store: Store(initialState: MainTabFeature.State(role: .student)) {
            MainTabFeature()
        }
    )
}
