import ComposableArchitecture

@Reducer
public struct NoticeManageFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {}

    public init() {}

    public var body: some ReducerOf<Self> {}
}
