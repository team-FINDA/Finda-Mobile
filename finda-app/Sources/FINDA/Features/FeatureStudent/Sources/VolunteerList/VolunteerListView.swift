import SwiftUI

struct VolunteerListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isShowingVolunteerPost = false

    private struct VolunteerPost: Identifiable {
        let id = UUID()
        let name: String
        let date: String
        let time: Int
    }

    private let volunteerPosts: [VolunteerPost] = [
        .init(name: "환경지킴이", date: "2025/04/16 ~ 2025/07/30", time: 8),
        .init(name: "교내 도서관 정리", date: "2025/03/10 ~ 2025/05/28", time: 12),
        .init(name: "지역사회 환경 캠페인", date: "2025/06/01 ~ 2025/08/15", time: 6)
    ]

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    FINDAImage("leftArrow").foregroundStyle(Color.gray80)
                }
                Spacer()
                Text("봉사활동 게시물").font(.finda(.body1)).foregroundColor(.gray90)
                Spacer()
                FINDAImage("leftArrow").opacity(0).accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(volunteerPosts) { post in
                        Button(action: { isShowingVolunteerPost = true }) {
                            VolunteerListCell(
                                volunteerName: post.name,
                                date: post.date,
                                time: post.time
                            )
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                    }
                }
                .padding(.top, 12)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: $isShowingVolunteerPost) {
            VolunteerPostView()
        }
    }
}
