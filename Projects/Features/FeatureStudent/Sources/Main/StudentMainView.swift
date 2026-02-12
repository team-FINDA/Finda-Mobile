import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct StudentMainView: View {
    @Perception.Bindable private var store: StoreOf<StudentMainFeature>

    public init(store: StoreOf<StudentMainFeature>) {
        self.store = store
    }

    public var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 20) {
                    MainHeaderView(
                        name: "2216 하원",
                        notificationAction: { store.send(.notificationButtonTapped) },
                        shortNotificationAction: { store.send(.shortNotificationButtonTapped) }
                    )

                    TotalTimeView(volunteerTime: 16)

                    GraphView()

                    VolunteerSearchButton(action: { store.send(.volunteerFindButtonTapped) })

                    Spacer()
                }
                .padding(.horizontal, 24.5)
            }
        }
    }
}

#Preview {
    StudentMainView(
        store: Store(initialState: StudentMainFeature.State()) {
            StudentMainFeature()
        })
}
