import SwiftUI

struct NewPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    let onChangeTapped: () -> Void
    @State private var passwordText = ""
    @State private var passwordConfirmText = ""

    var isDisabled: Bool {
        passwordText.isEmpty ||
        passwordConfirmText.isEmpty ||
        passwordText != passwordConfirmText
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    FINDAImage("leftArrow").foregroundStyle(Color.gray80)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            Text("비밀번호 변경")
                .font(.finda(.heading4))
                .foregroundStyle(Color.gray80)
                .padding(.bottom, 64)

            VStack(spacing: 32) {
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
                    buttonText: "비밀번호 변경",
                    isDisabled: isDisabled,
                    buttonClick: { onChangeTapped() }
                )
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .dismissKeyboardOnTap()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
        .background(Color.gray10.ignoresSafeArea())
    }
}
