import SwiftUI

struct SigninView: View {
    let role: UserRole
    var viewModel: AuthViewModel
    @State private var emailText = ""
    @State private var passwordText = ""
    @Environment(\.dismiss) private var dismiss

    var isDisabled: Bool {
        emailText.isEmpty || passwordText.isEmpty
    }

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

            Text("로그인")
                .font(.finda(.heading4))
                .foregroundStyle(Color.gray80)
                .padding(.bottom, 64)

            VStack(spacing: 32) {
                AuthTextField(
                    type: role == .student ? .schoolEmail : .base,
                    placeholder: "이메일을 입력해주세요",
                    text: $emailText
                )
                AuthTextField(
                    type: .password,
                    placeholder: "비밀번호를 입력해주세요",
                    text: $passwordText
                )
                FINDAButton(
                    buttonText: "로그인",
                    isDisabled: isDisabled,
                    buttonClick: { viewModel.completeAuthentication(role: role) }
                )
                AuthPromptButton(
                    promptText: "계정이 없으신가요?",
                    buttonText: "회원가입",
                    action: { viewModel.signupTapped() }
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
