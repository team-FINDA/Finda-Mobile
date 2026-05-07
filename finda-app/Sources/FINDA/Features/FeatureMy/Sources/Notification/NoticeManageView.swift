import SwiftUI

@Observable
class NoticeManageViewModel {
    var noticeItems: [NoticeItem] = [
        .init(id: "1", title: "꽃에 물주러 오세요", content: "오늘은 화단 물주기 봉사활동이 있습니다.", date: "2025.06.30", time: "13:00"),
        .init(id: "2", title: "교감쌤과 바둑 활동 안내", content: "교감쌤과 함께 바둑 대국 봉사활동을 진행합니다.", date: "2025.07.01", time: "09:30"),
        .init(id: "3", title: "환경 지킴이하러 오세요~", content: "학교 주변 정화 활동을 함께 진행해주세요.", date: "2025.07.03", time: "15:10")
    ]
    var selectedNotice: NoticeItem?
    var isShowingDetail = false
    var isShowingCreate = false
}

struct NoticeManageView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = NoticeManageViewModel()

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { dismiss() }) {
                    FINDAImage("leftArrow")
                        .foregroundStyle(Color.gray80)
                }
                Spacer()
                Text("공지사항 관리")
                    .font(.finda(.body1))
                    .foregroundColor(.gray90)
                Spacer()
                Button(action: { viewModel.isShowingCreate = true }) {
                    FINDAImage("add")
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            ScrollView {
                LazyVStack(spacing: 4) {
                    ForEach(viewModel.noticeItems) { item in
                        NoticeAlertListCell(
                            title: item.title,
                            date: item.date,
                            time: item.time,
                            action: {
                                viewModel.selectedNotice = item
                                viewModel.isShowingDetail = true
                            }
                        )
                    }
                }
                .padding(.horizontal, 24)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: $viewModel.isShowingDetail) {
            if let notice = viewModel.selectedNotice {
                NoticeDetailView(mode: .edit(.init(
                    title: notice.title,
                    content: notice.content,
                    date: notice.date,
                    time: notice.time
                )))
            }
        }
        .navigationDestination(isPresented: $viewModel.isShowingCreate) {
            NoticeDetailView(mode: .create)
        }
    }
}
