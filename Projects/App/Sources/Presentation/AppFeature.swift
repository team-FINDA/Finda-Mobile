import ComposableArchitecture
import FeatureAuth

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var isShowingSplash = true
        var authRoot = AuthRootFeature.State()

        init() {}
    }

    enum Action {
        case onAppear
        case splashFinished
        case authRoot(AuthRootFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {
        Scope(state: \.authRoot, action: \.authRoot) {
            AuthRootFeature()
        }

        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    try await Task.sleep(for: .seconds(1.2))
                    await send(.splashFinished)
                }

            case .splashFinished:
                state.isShowingSplash = false
                return .none

            case .authRoot:
                return .none
            }
        }
    }
}
