import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<SettingFeature>

    init(store: StoreOf<SettingFeature>) {
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

                    Text("설정")
                        .font(.finda(.body1))
                        .foregroundColor(.Gray.gray90)

                    Spacer()

                    Image.Icons.leftArrow
                        .opacity(0)
                        .accessibilityHidden(true)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)

                VStack(spacing: 40) {
                    Image.Images.baseProfile
                        .clipShape(.circle)

                    SettingButton(
                        buttonText: "알림 설정",
                        textColor: Color.Gray.gray90,
                        action: {}
                    )
                    SettingButton(
                        buttonText: "비밀번호 설정",
                        textColor: Color.Blue.blue50,
                        action: { store.send(.passwordChangeButtonTapped) }
                    )

                    VStack(spacing: 16) {
                        SettingButton(
                            buttonText: "로그아웃",
                            action: { store.send(.signoutButtonTapped) }
                        )
                        SettingButton(
                            buttonText: "회원탈퇴",
                            action: { store.send(.resignButtonTapped) }
                        )
                    }

                    Spacer()
                }
                .padding(.horizontal, 24)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
            .toolbar(.hidden, for: .tabBar)
            .overlay {
                if store.isPopupPresented {
                    ZStack {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()

                        SettingPopup(
                            title: store.popupTitle,
                            content: store.popupContent,
                            cancelAction: { store.send(.dismissPopup) },
                            okAction: { store.send(.popupOkButtonTapped) }
                        )
                        .padding(.horizontal, 52)
                    }
                }
            }
        }
    }
}

#Preview {
    SettingView(
        store: Store(initialState: SettingFeature.State()) {
            SettingFeature()
        }
    )
}
