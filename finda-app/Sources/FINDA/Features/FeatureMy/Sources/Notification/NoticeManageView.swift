#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

struct NoticeManageView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<NoticeManageFeature>

    public init(store: StoreOf<NoticeManageFeature>) {
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

                    Text("공지사항 관리")
                        .font(.finda(.body1))
                        .foregroundColor(.Gray.gray90)

                    Spacer()

                    Button(action: {
                        store.send(.addButtonTapped)
                    }, label: {
                        Image.Icons.add
                    })
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)

                ScrollView {
                    LazyVStack(spacing: 4) {
                        ForEach(store.noticeItems) { item in
                            NoticeAlertListCell(
                                title: item.title,
                                date: item.date,
                                time: item.time,
                                action: {
                                    store.send(.noticeItemTapped(item))
                                }
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
}

#Preview {
    NoticeManageView(
        store: Store(initialState: NoticeManageFeature.State()) {
            NoticeManageFeature()
        }
    )
}

#endif
