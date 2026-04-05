#if !SKIP
import SwiftUI
import DesignSystem

struct VolunteerListView: View {
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

    @State private var isShowingVolunteerPost = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }, label: {
                    Image.Icons.leftArrow
                        .foregroundStyle(Color.Gray.gray80)
                })

                Spacer()

                Text("봉사활동 게시물")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)

                Spacer()

                Image.Icons.leftArrow
                    .opacity(0)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            List {
                ForEach(volunteerPosts) { post in
                    Button(action: {
                        isShowingVolunteerPost = true
                    }, label: {
                        VolunteerListCell(
                            volunteerName: post.name,
                            date: post.date,
                            time: post.time
                        )
                    })
                    .buttonStyle(.plain)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.top, 12)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .navigationDestination(isPresented: $isShowingVolunteerPost) {
            VolunteerPostView()
        }
    }
}

#Preview {
    VolunteerListView()
}

#endif
