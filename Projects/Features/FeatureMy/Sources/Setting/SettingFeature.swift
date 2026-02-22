import ComposableArchitecture
import Shared

@Reducer
public struct SettingFeature {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }

    public enum Action {}

    public init() {}

    public var body: some ReducerOf<Self> {}
}
