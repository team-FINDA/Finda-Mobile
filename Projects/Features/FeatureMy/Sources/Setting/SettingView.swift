import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<SettingFeature>
    @State private var isPopupPresented = false
    @State private var popupTitle = ""
    @State private var popupContent = ""

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
                        action: {}
                    )

                    VStack(spacing: 16) {
                        SettingButton(
                            buttonText: "로그아웃",
                            action: {
                                popupTitle = "로그아웃"
                                popupContent = "정말 로그아웃 하시겠습니까?\n로그아웃 시 다시 로그인해야 합니다."
                                isPopupPresented = true
                            }
                        )
                        SettingButton(
                            buttonText: "회원탈퇴",
                            action: {
                                popupTitle = "회원탈퇴"
                                popupContent = "정말 회원탈퇴 하시겠습니까?\n회원탈퇴 시 모든 정보가 사라집니다."
                                isPopupPresented = true
                            }
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
                if isPopupPresented {
                    ZStack {
                        Color.black.opacity(0.5)
                            .ignoresSafeArea()

                        SettingPopup(
                            title: popupTitle,
                            content: popupContent,
                            cancelAction: { isPopupPresented = false },
                            okAction: { isPopupPresented = false }
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
