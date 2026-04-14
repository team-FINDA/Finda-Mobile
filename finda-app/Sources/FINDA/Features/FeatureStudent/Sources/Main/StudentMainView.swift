import SwiftUI

@Observable
class StudentMainViewModel {
    var path: [StudentPath] = []

    enum StudentPath: Hashable {
        case volunteerList
    }

    func volunteerFindTapped() {
        path.append(.volunteerList)
    }
}

public struct StudentMainView: View {
    @State private var viewModel = StudentMainViewModel()

    public init() {}

    public var body: some View {
        NavigationStack(path: $viewModel.path) {
            ScrollView {
                VStack(spacing: 20) {
                    MainHeaderView(
                        name: "2216 하원",
                        notificationAction: { },
                        shortNotificationAction: { }
                    )
                    TotalTimeView(volunteerTime: Float(16.0))
                    GraphView()
                    VolunteerSearchButton(action: { viewModel.volunteerFindTapped() })
                    Spacer()
                }
                .padding(.horizontal, 24.5)
            }
            .navigationDestination(for: StudentMainViewModel.StudentPath.self) { path in
                switch path {
                case .volunteerList:
                    VolunteerListView()
                }
            }
        }
    }
}
