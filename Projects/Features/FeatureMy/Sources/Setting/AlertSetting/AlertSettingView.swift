import SwiftUI
import DesignSystem

struct VolunteerAlertSettingItem: Identifiable, Equatable {
    let id: String
    let title: String
    var isOn: Bool
}

struct AlertSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var noticeToggleOn = false
    @State private var totalToggleOn = false
    @State private var volunteerAlertItems: [VolunteerAlertSettingItem]

    init(volunteerAlertItems: [VolunteerAlertSettingItem] = Self.previewVolunteerAlertItems) {
        self._volunteerAlertItems = State(initialValue: volunteerAlertItems)
    }

    var body: some View {
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
                CustomToggle(title: "공지사항", font: .finda(.subheading2), isOn: $noticeToggleOn)
                CustomToggle(title: "봉사활동 전체", font: .finda(.subheading2), isOn: $totalToggleOn)
                    .onChange(of: totalToggleOn) { isOn in
                        guard isOn else { return }
                        for index in volunteerAlertItems.indices {
                            volunteerAlertItems[index].isOn = true
                        }
                    }

                VStack(spacing: 20) {
                    ForEach(Array(volunteerAlertItems.enumerated()), id: \.element.id) { index, item in
                        let isOnBinding = Binding(
                            get: { volunteerAlertItems[index].isOn },
                            set: { newValue in
                                volunteerAlertItems[index].isOn = newValue
                                if !newValue {
                                    totalToggleOn = false
                                } else {
                                    totalToggleOn = volunteerAlertItems.allSatisfy(\.isOn)
                                }
                            }
                        )
                        CustomToggle(title: item.title, font: .finda(.subheading2), isOn: isOnBinding)
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
private extension AlertSettingView {
    static let previewVolunteerAlertItems: [VolunteerAlertSettingItem] = [
        .init(id: "1", title: "환경 지킴이 활동", isOn: false),
        .init(id: "2", title: "교감쌤과 바둑두기", isOn: true),
        .init(id: "3", title: "화단에 물주기", isOn: false)
    ]
}

#Preview {
    AlertSettingView()
}
