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
                    HStack(spacing: 16) {
                        Image.Images.baseProfile
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome,")
                                .font(.finda(.body4))
                                .foregroundStyle(Color.Gray.gray60)
                            Text("2216 하원")
                                .font(.finda(.body1))
                        }

                        Spacer()

                        Button {
                            store.send(.notificationButtonTapped)
                        } label: {
                            Image.Icons.bell
                        }

                    }
                    .padding(.top, 20)

                    HStack(spacing: 3.5) {
                        Image.Icons.speakerphone

                        Text("FINDA에 새로운 기능이 추가되었어요!")
                            .font(.finda(.body4))
                            .foregroundStyle(Color.Gray.gray80)

                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 9)
                    .background(Color.Blue.blue10.cornerRadius(20))
                    .onTapGesture {
                        store.send(.shortnotificationButtonTapped)
                    }

                    TotalTimeView(volunteerTime: 16)

                    GraphView()

                    VolunteerSearchButton(action: { store.send(.volunteerfindButtonTapped) })

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
