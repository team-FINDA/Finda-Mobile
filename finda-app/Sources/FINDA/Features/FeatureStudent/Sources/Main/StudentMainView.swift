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
            ZStack {
                Color.gray10.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        MainHeaderView(
                            name: "2216 하원",
                            notificationAction: { },
                            shortNotificationAction: { }
                        )
                        TotalTimeView(volunteerTime: 16.0)
                        GraphView()
                        VolunteerSearchButton(action: { viewModel.volunteerFindTapped() })
                        Spacer()
                    }
                    .padding(.horizontal, 24.5)
                }
            }
            .navigationDestination(for: StudentMainViewModel.StudentPath.self) { path in
                switch path {
                case .volunteerList:
                    VolunteerListView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
    }
}
