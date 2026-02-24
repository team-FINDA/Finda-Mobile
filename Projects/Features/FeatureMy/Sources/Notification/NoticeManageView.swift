import SwiftUI
import DesignSystem

private struct NoticeAlertItem: Identifiable {
    let id: String
    let title: String
    let date: String
    let time: String
}

struct NoticeManageView: View {
    @Environment(\.dismiss) private var dismiss
    private let noticeItems: [NoticeAlertItem] = [
        .init(id: "1", title: "꽃에 물주러 오세요", date: "2025.06.30", time: "13:00"),
        .init(id: "2", title: "교감쌤과 바둑 활동 안내", date: "2025.07.01", time: "09:30"),
        .init(id: "3", title: "환경 지킴이하러 오세요~", date: "2025.07.03", time: "15:10")
    ]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { dismiss() }, label: {
                    Image.Icons.leftArrow
                        .foregroundStyle(Color.Gray.gray80)
                })

                Spacer()

                Text("공지사항 관리")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)

                Spacer()

                Button(action: {}, label: {
                    Image.Icons.add
                })
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(noticeItems) { item in
                        NoticeAlertListCell(
                            title: item.title,
                            date: item.date,
                            time: item.time,
                            action: {}
                        )
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NoticeManageView()
}
