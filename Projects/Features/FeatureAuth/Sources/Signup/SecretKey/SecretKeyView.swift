import SwiftUI
import DesignSystem

struct SecretKeyView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var secretKeyText: String
    var signupButtonIsDisable: Bool = true

    init(
        secretKeyText: Binding<String>,
        signupButtonIsDisable: Bool
    ) {
        self._secretKeyText = secretKeyText
        self.signupButtonIsDisable = signupButtonIsDisable
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }, label: {
                    Image.Icons.leftArrow
                        .foregroundStyle(Color.Gray.gray80)
                })
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            Text("회원가입")
                .font(.finda(.heading4))
                .foregroundStyle(Color.Gray.gray80)
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
                    isDisabled: signupButtonIsDisable,
                    buttonClick: {}
                )
                AuthPromptButton(
                    promptText: "계정이 있으신가요?",
                    buttonText: "로그인",
                    action: {}
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

#Preview {
    SecretKeyView(
        secretKeyText: .constant(""),
        signupButtonIsDisable: true
    )
}
