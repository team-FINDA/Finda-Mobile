import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    var viewModel: MyRootViewModel
    @State private var isPopupPresented = false
    @State private var popupTitle = ""
    @State private var popupContent = ""

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { dismiss() }) {
                    FINDAImage("leftArrow").foregroundStyle(Color.gray80)
                }
                Spacer()
                Text("설정").font(.finda(.body1)).foregroundColor(.gray90)
                Spacer()
                FINDAImage("leftArrow").opacity(0).accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            VStack(spacing: 40) {
                FINDAImage("baseProfile").clipShape(.circle)

                SettingButton(
                    buttonText: "알림 설정",
                    textColor: Color.gray90,
                    action: { viewModel.alertSettingTapped() }
                )
                SettingButton(
                    buttonText: "비밀번호 설정",
                    textColor: Color.blue50,
                    action: { viewModel.passwordChangeTapped() }
                )

                VStack(spacing: 16) {
                    SettingButton(buttonText: "로그아웃") {
                        popupTitle = "로그아웃"
                        popupContent = "정말 로그아웃 하시겠습니까?\n로그아웃 시 다시 로그인해야 합니다."
                        isPopupPresented = true
                    }
                    SettingButton(buttonText: "회원탈퇴") {
                        popupTitle = "회원탈퇴"
                        popupContent = "정말 회원탈퇴 하시겠습니까?\n회원탈퇴 시 모든 정보가 사라집니다."
                        isPopupPresented = true
                    }
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
                    Color.black.opacity(0.5).ignoresSafeArea()
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
