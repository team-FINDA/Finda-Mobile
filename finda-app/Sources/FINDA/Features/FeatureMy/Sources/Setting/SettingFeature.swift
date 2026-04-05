#if !SKIP
import ComposableArchitecture
import Shared

@Reducer
public struct SettingFeature {
    @ObservableState
    public struct State: Equatable {
        var isPopupPresented = false
        var popupTitle = ""
        var popupContent = ""

        public init() {}
    }

    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case alertSettingButtonTapped
        case passwordChangeButtonTapped
        case signoutButtonTapped
        case resignButtonTapped
        case dismissPopup
        case popupOkButtonTapped
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .alertSettingButtonTapped:
                return .none

            case .passwordChangeButtonTapped:
                return .none

            case .signoutButtonTapped:
                state.popupTitle = "로그아웃"
                state.popupContent = "정말 로그아웃 하시겠습니까?\n로그아웃 시 다시 로그인해야 합니다."
                state.isPopupPresented = true
                return .none

            case .resignButtonTapped:
                state.popupTitle = "회원탈퇴"
                state.popupContent = "정말 회원탈퇴 하시겠습니까?\n회원탈퇴 시 모든 정보가 사라집니다."
                state.isPopupPresented = true
                return .none

            case .dismissPopup, .popupOkButtonTapped:
                state.isPopupPresented = false
                return .none

            case .binding:
                return .none
            }
        }
    }
}

#endif
