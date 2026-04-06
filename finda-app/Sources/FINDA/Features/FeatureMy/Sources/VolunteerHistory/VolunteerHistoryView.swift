#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

struct VolunteerHistoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<VolunteerHistoryFeature>

    private let historyItems: [VolunteerHistoryItem] = [
        .init(title: "환경지킴이", date: "2025.12.28", time: 2),
        .init(title: "iOS 멘토링", date: "2026.02.21", time: 100),
        .init(title: "조기 귀가", date: "2025.10.02", time: 0.1)
    ]

    init(store: StoreOf<VolunteerHistoryFeature>) {
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

                    Text("봉사활동 내역")
                        .font(.finda(.body1))
                        .foregroundColor(.Gray.gray90)

                    Spacer()

                    Image.Icons.leftArrow
                        .opacity(0)
                        .accessibilityHidden(true)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)

                VStack {
                    TotalTimeView(volunteerTime: 102.1)

                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(historyItems) { item in
                                HistoryListCell(
                                    title: item.title,
                                    date: item.date,
                                    time: item.time
                                )
                            }
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 12)
                    }
                }
                .padding(.horizontal, 24)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

private struct VolunteerHistoryItem: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let time: Float
}

#Preview {
    VolunteerHistoryView(
        store: Store(initialState: VolunteerHistoryFeature.State()) {
            VolunteerHistoryFeature()
        }
    )
}

#endif
