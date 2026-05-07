import SwiftUI

struct EmailVerificationView: View {
    var viewModel: AuthViewModel
    @State private var emailText = ""
    @State private var codeText = ""
    @Environment(\.dismiss) private var dismiss

    var isDisabled: Bool { emailText.isEmpty || codeText.isEmpty }

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
                    type: viewModel.selectedRole == .student ? .schoolVerificationEmail : .verificationEmail,
                    placeholder: viewModel.selectedRole == .student ? "example" : "이메일을 입력해주세요",
                    text: $emailText
                )
                AuthTextField(
                    type: .base,
                    placeholder: "인증 코드를 입력해주세요",
                    label: "인증 코드",
                    text: $codeText
                )
                FINDAButton(
                    buttonText: "다음",
                    isDisabled: isDisabled,
                    buttonClick: { viewModel.emailVerificationNextTapped() }
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
