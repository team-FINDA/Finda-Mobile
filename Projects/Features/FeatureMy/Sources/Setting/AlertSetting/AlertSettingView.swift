import SwiftUI
import ComposableArchitecture
import DesignSystem

struct AlertSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<AlertSettingFeature>

    init(store: StoreOf<AlertSettingFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 20) {
                HStack {
                    Button(action: { dismiss() }, label: {
                        Image.Icons.leftArrow
                            .foregroundStyle(Color.Gray.gray80)
                    })

                     Spacer()

                    Text("알림 설정")
                        .font(.finda(.body1))
                        .foregroundColor(.Gray.gray90)

                    Spacer()

                    Image.Icons.leftArrow
                        .opacity(0)
                        .accessibilityHidden(true)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)

                VStack(spacing: 40) {
                    CustomToggle(
                        title: "공지사항",
                        font: .finda(.subheading2),
                        isOn: Binding(
                            get: { store.noticeToggleOn },
                            set: { store.send(.noticeToggleChanged($0)) }
                        )
                    )
                    CustomToggle(
                        title: "봉사활동 전체",
                        font: .finda(.subheading2),
                        isOn: Binding(
                            get: { store.totalToggleOn },
                            set: { store.send(.totalToggleChanged($0)) }
                        )
                    )

                    VStack(spacing: 20) {
                        ForEach(store.volunteerAlertItems) { item in
                            CustomToggle(
                                title: item.title,
                                font: .finda(.body1),
                                isOn: Binding(
                                    get: { item.isOn },
                                    set: { store.send(.volunteerToggleChanged(id: item.id, isOn: $0)) }
                                )
                            )
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    AlertSettingView(
        store: Store(initialState: AlertSettingFeature.State()) {
            AlertSettingFeature()
        }
    )
}
