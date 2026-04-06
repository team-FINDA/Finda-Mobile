#if !SKIP && canImport(UIKit)
import ComposableArchitecture

@Reducer
public struct NoticeManageFeature {
    @ObservableState
    public struct State: Equatable {
        var noticeItems: [NoticeItem]

        public init(noticeItems: [NoticeItem] = Self.defaultNoticeItems) {
            self.noticeItems = noticeItems
        }

        public static let defaultNoticeItems: [NoticeItem] = [
            .init(
                id: "1",
                title: "꽃에 물주러 오세요",
                content: "오늘은 화단 물주기 봉사활동이 있습니다.",
                date: "2025.06.30",
                time: "13:00"
            ),
            .init(
                id: "2",
                title: "교감쌤과 바둑 활동 안내",
                content: "교감쌤과 함께 바둑 대국 봉사활동을 진행합니다.",
                date: "2025.07.01",
                time: "09:30"
            ),
            .init(
                id: "3",
                title: "환경 지킴이하러 오세요~",
                content: "학교 주변 정화 활동을 함께 진행해주세요.",
                date: "2025.07.03",
                time: "15:10"
            )
        ]
    }

    public enum Action {
        case addButtonTapped
        case noticeItemTapped(NoticeItem)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { _, _ in
            .none
        }
    }
}

public struct NoticeItem: Equatable, Identifiable, Sendable {
    public let id: String
    public let title: String
    public let content: String
    public let date: String
    public let time: String

    public init(id: String, title: String, content: String, date: String, time: String) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.time = time
    }
}

#endif
