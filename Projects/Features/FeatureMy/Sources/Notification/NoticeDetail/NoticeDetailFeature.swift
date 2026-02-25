import ComposableArchitecture

@Reducer
public struct NoticeDetailFeature {
    public struct EditData: Equatable {
        public let title: String
        public let content: String
        public let date: String
        public let time: String

        public init(title: String, content: String, date: String, time: String) {
            self.title = title
            self.content = content
            self.date = date
            self.time = time
        }
    }

    public enum Mode: Equatable {
        case create
        case edit(EditData)
    }

    @ObservableState
    public struct State: Equatable {
        public var mode: Mode

        public init(mode: Mode = .create) {
            self.mode = mode
        }
    }

    public enum Action {}

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { _, _ in .none }
    }
}
