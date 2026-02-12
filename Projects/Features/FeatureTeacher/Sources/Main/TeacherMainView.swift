import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct TeacherMainView: View {
    private let students: [(name: String, state: Bool)] = [
        ("2216 하원", false),
        ("2205 김시우", false),
        ("2207 변도휘", true)
    ]
    @Perception.Bindable private var store: StoreOf<TeacherMainFeature>

    public init(store: StoreOf<TeacherMainFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 20) {
                MainHeaderView(
                    name: "하원 선생님",
                    notificationAction: { store.send(.notificationButtonTapped) },
                    shortNotificationAction: { store.send(.shortNotificationButtonTapped) }
                )

                HStack(spacing: 12) {
                    Button(action: { store.send(.changeButtonTapped) }, label: {
                        HStack(spacing: 8) {
                            Text("환경지킴이")
                                .font(.finda(.body1))
                                .foregroundColor(.Gray.gray90)

                            Image.Icons.change
                        }
                        .padding(12)
                        .background(Color.Gray.gray20)
                        .cornerRadius(4)
                    })

                    Text("학생")
                        .font(.finda(.body1))
                        .foregroundColor(.Gray.gray90)

                    Spacer()
                }

                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(Array(students.enumerated()), id: \.offset) { _, student in
                            StudentListCell(name: student.name, state: student.state)
                        }
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    TeacherMainView(
        store: Store(initialState: TeacherMainFeature.State()) {
            TeacherMainFeature()
        })
}
