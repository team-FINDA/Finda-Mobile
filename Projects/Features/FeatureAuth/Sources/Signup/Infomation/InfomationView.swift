import SwiftUI
import DesignSystem

struct InfomationView: View {
    @Environment(\.dismiss) private var dismiss
    private let selectedRole: SigninUserType?
    @Binding private var name: String
    @Binding private var password: String
    @Binding private var passwordConfirm: String

    init(
        selectedRole: SigninUserType?,
        name: Binding<String>,
        password: Binding<String>,
        passwordConfirm: Binding<String>
    ) {
        self.selectedRole = selectedRole
        self._name = name
        self._password = password
        self._passwordConfirm = passwordConfirm
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

            ViewThatFits(in: .vertical) {
                Text("회원가입")
                    .font(.finda(.heading4))
                    .foregroundStyle(Color.Gray.gray80)
                    .padding(.bottom, 64)
                Text("회원가입")
                    .font(.finda(.heading4))
                    .foregroundStyle(Color.Gray.gray80)
                    .padding(.bottom, 48)
            }

            VStack(spacing: 32) {
                AuthTextField(
                    type: .base,
                    placeholder: selectedRole == .student ? "ex. 2216 하원" : "실명을 입력해주세요",
                    label: selectedRole == .student ? "학번 이름" : "이름",
                    text: $name
                )
                VStack(alignment: .leading, spacing: 4) {
                    AuthTextField(
                        type: .password,
                        placeholder: "비밀번호를 입력해주세요",
                        text: $password
                    )
                    Text("비밀번호는 이런이런이런 형식으로 ㄱㄱ")
                        .font(.finda(.body4))
                        .foregroundStyle(Color.Blue.blue50)
                }
                AuthTextField(
                    type: .password,
                    placeholder: "비밀번호를 다시 입력해주세요",
                    label: "비밀번호 확인",
                    text: $passwordConfirm
                )

                FINDAButton(
                    buttonText: "다음",
                    isDisabled: false,
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
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 32)
        }
        .dismissKeyboardOnTap()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    InfomationView(selectedRole: .student, name: .constant(""), password: .constant(""), passwordConfirm: .constant(""))
}
