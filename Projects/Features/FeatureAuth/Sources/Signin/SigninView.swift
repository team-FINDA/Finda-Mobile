import SwiftUI
import DesignSystem

struct SigninView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var emailText: String
    @Binding var passwordText: String
    var signinButtonIsDisabled: Bool = true

    init(
        emailText: Binding<String>,
        passwordText: Binding<String>,
        signinButtonIsDisabled: Bool
    ) {
        self._emailText = emailText
        self._passwordText = passwordText
        self.signinButtonIsDisabled = signinButtonIsDisabled
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

            Text("로그인")
                .font(.finda(.heading4))
                .foregroundStyle(Color.Gray.gray80)
                .padding(.bottom, 64)

            VStack(spacing: 32) {
                VStack(spacing: 24) {
                    AuthTextField(
                        type: .base,
                        placeholder: "이메일을 입력해주세요",
                        text: $emailText
                    )
                    AuthTextField(
                        type: .password,
                        placeholder: "비밀번호를 입력해주세요",
                        text: $passwordText
                    )
                }
                FINDAButton(
                    buttonText: "로그인",
                    isDisabled: signinButtonIsDisabled,
                    buttonClick: {}
                )
                AuthPromptButton(
                    promptText: "계정이 없으신가요?",
                    buttonText: "회원가입",
                    action: {}
                )
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    struct SigninView_PreviewWrapper: View {
        @State private var email: String = ""
        @State private var password: String = ""
        var body: some View {
            SigninView(
                emailText: $email,
                passwordText: $password,
                signinButtonIsDisabled: true
            )
        }
    }
    return SigninView_PreviewWrapper()
}
