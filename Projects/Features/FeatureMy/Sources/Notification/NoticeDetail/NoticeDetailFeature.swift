import ComposableArchitecture

@Reducer
public struct NoticeDetailFeature {

    public enum Mode: Equatable {
        case create
        case edit(EditData)
    }

    @ObservableState
    public struct State: Equatable {
        let mode: Mode

        public init(mode: Mode = .create) {
            self.mode = mode
        }
    }

    public enum Action {}

    public init() {}

    public var body: some ReducerOf<Self> {}
}

public struct EditData: Equatable {
    let title: String
    let content: String
    let date: String
    let time: String
}
