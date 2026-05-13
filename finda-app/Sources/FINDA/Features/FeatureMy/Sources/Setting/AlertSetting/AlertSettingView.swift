import SwiftUI

struct AlertSettingItem: Identifiable {
    let id: String
    let title: String
    var isOn: Bool
}

@Observable
class AlertSettingViewModel {
    var noticeToggleOn = false
    var totalToggleOn = false
    var volunteerAlertItems: [AlertSettingItem] = [
        .init(id: "1", title: "환경 지킴이 활동", isOn: false),
        .init(id: "2", title: "교감쌤과 바둑두기", isOn: true),
        .init(id: "3", title: "화단에 물주기", isOn: false)
    ]

    func totalToggleChanged(_ isOn: Bool) {
        totalToggleOn = isOn
        if isOn {
            for i in volunteerAlertItems.indices {
                volunteerAlertItems[i].isOn = true
            }
        }
    }

    func volunteerToggleChanged(id: String, isOn: Bool) {
        guard let index = volunteerAlertItems.firstIndex(where: { $0.id == id }) else { return }
        volunteerAlertItems[index].isOn = isOn
        totalToggleOn = volunteerAlertItems.allSatisfy(\.isOn)
    }
}

struct AlertSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = AlertSettingViewModel()

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { dismiss() }) {
                    FINDAImage("leftArrow").foregroundStyle(Color.gray80)
                }
                Spacer()
                Text("알림 설정").font(Font.finda(.body1)).foregroundColor(.gray90)
                Spacer()
                FINDAImage("leftArrow").opacity(0).accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            VStack(spacing: 40) {
                CustomToggle(title: "공지사항", font: Font.finda(.subheading2), isOn: $viewModel.noticeToggleOn)
                CustomToggle(
                    title: "봉사활동 전체",
                    font: Font.finda(.subheading2),
                    isOn: Binding(
                        get: { viewModel.totalToggleOn },
                        set: { viewModel.totalToggleChanged($0) }
                    )                                                                                                                                                                                                                                                                                                                                 
                )

                VStack(spacing: 20) {
                    ForEach(viewModel.volunteerAlertItems) { item in
                        CustomToggle(
                            title: item.title,
                            font: Font.finda(.body1),
                            isOn: Binding(
                                get: { item.isOn },
                                set: { viewModel.volunteerToggleChanged(id: item.id, isOn: $0) }
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
        .toolbar(.hidden, for: .tabBar)
        .background(Color.gray10.ignoresSafeArea())
    }
}
