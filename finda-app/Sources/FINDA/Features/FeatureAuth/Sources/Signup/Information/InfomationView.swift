import SwiftUI

struct InformationView: View {
    var viewModel: AuthViewModel
    @State private var nameText = ""
    @State private var passwordText = ""
    @State private var passwordConfirmText = ""
    @Environment(\.dismiss) private var dismiss

    var isDisabled: Bool {
        nameText.isEmpty ||
        passwordText.isEmpty ||
        passwordConfirmText.isEmpty ||
        passwordText != passwordConfirmText
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

            Text("회원가입")
                .font(.finda(.heading4))
                .foregroundStyle(Color.gray80)
                .padding(.bottom, 64)

            VStack(spacing: 32) {
                AuthTextField(
                    type: .base,
                    placeholder: viewModel.selectedRole == .student ? "ex. 2216 하원" : "실명을 입력해주세요",
                    label: viewModel.selectedRole == .student ? "학번 이름" : "이름",
                    text: $nameText
                )
                VStack(alignment: .leading, spacing: 4) {
                    AuthTextField(
                        type: .password,
                        placeholder: "비밀번호를 입력해주세요",
                        text: $passwordText
                    )
                    Text("비밀번호는 이런이런이런 형식으로 ㄱㄱ")
                        .font(.finda(.body4))
                        .foregroundStyle(Color.blue50)
                }
                AuthTextField(
                    type: .password,
                    placeholder: "비밀번호를 다시 입력해주세요",
                    label: "비밀번호 확인",
                    text: $passwordConfirmText
                )
                FINDAButton(
                    buttonText: "회원가입",
                    isDisabled: isDisabled,
                    buttonClick: { }
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
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 32)
        }
        .dismissKeyboardOnTap()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
