import SwiftUI

struct SecretKeyView: View {
    var viewModel: AuthViewModel
    @State private var secretKeyText = ""
    @Environment(\.dismiss) private var dismiss

    var isDisabled: Bool { secretKeyText.isEmpty }

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    FINDAImage("leftArrow")
                        .foregroundStyle(Color.gray80)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            Text("회원가입")
                .font(.finda(.heading4))
                .foregroundStyle(Color.gray80)
                .padding(.bottom, 64)

            VStack(spacing: 32) {
                AuthTextField(
                    type: .base,
                    placeholder: "시크릿 키를 입력해주세요",
                    label: "시크릿 키",
                    text: $secretKeyText
                )
                FINDAButton(
                    buttonText: "다음",
                    isDisabled: isDisabled,
                    buttonClick: { viewModel.secretKeyNextTapped() }
                )
                AuthPromptButton(
                    promptText: "계정이 있으신가요?",
                    buttonText: "로그인",
                    action: { viewModel.backToRoot() }
                )
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .dismissKeyboardOnTap()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
