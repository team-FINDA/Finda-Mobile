import ComposableArchitecture
import FeatureAuth
import Shared

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var isShowingSplash = true
        var authRoot = AuthRootFeature.State()
        var mainTab: MainTabFeature.State?

        init() {}
    }

    enum Action {
        case onAppear
        case splashFinished
        case authRoot(AuthRootFeature.Action)
        case mainTab(MainTabFeature.Action)
    }

    init() {}

    var body: some ReducerOf<Self> {
        Scope(state: \.authRoot, action: \.authRoot) {
            AuthRootFeature()
        }
        .ifLet(\.mainTab, action: \.mainTab) {
            MainTabFeature()
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

            case .authRoot(.path(.element(id: _, action: .signin(.signinButtonTapped)))):
                let role = state.authRoot.selectedRole ?? .student
                state.mainTab = MainTabFeature.State(role: role)
                return .none

            case .authRoot:
                return .none

            case .mainTab:
                return .none
            }
        }
    }
}
