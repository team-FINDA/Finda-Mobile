import SwiftUI

@Observable
class TeacherMainViewModel {
    var selectedActivity = "환경지킴이"
}

public struct TeacherMainView: View {
    @State private var viewModel = TeacherMainViewModel()

    private let students: [(name: String, state: Bool)] = [
        ("2216 하원", false),
        ("2205 김시우", false),
        ("2207 변도휘", true)
    ]

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                MainHeaderView(
                    name: "하원 선생님",
                    notificationAction: { },
                    shortNotificationAction: { }
                )

                HStack(spacing: 12) {
                    Button(action: { }) {
                        HStack(spacing: 8) {
                            Text(viewModel.selectedActivity)
                                .font(.finda(.body1))
                                .foregroundColor(.gray90)
                            FINDAImage("change")
                        }
                        .padding(12)
                        .background(Color.gray20)
                        .cornerRadius(4)
                    }

                    Text("학생")
                        .font(.finda(.body1))
                        .foregroundColor(.gray90)

                    Spacer()
                }

                LazyVStack(spacing: 8) {
                    ForEach(Array(students.enumerated()), id: \.offset) { _, student in
                        StudentListCell(name: student.name, state: student.state)
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .frame(maxWidth: .infinity, alignment: .top)
        }
        .background(Color.gray10.ignoresSafeArea())
    }
}
