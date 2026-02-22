import SwiftUI
import DesignSystem

struct NewPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var passwordText: String
    @Binding var passwordConfirmationText: String

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
                Text("비밀번호 변경")
                    .font(.finda(.heading4))
                    .foregroundStyle(Color.Gray.gray80)
                    .padding(.bottom, 64)
            }

            VStack(spacing: 32) {
                VStack(alignment: .leading, spacing: 4) {
                    AuthTextField(
                        type: .password,
                        placeholder: "비밀번호를 입력해주세요",
                        text: $passwordText
                    )
                    Text("비밀번호는 이런이런이런 형식으로 ㄱㄱ")
                        .font(.finda(.body4))
                        .foregroundStyle(Color.Blue.blue50)
                }
                AuthTextField(
                    type: .password,
                    placeholder: "비밀번호를 다시 입력해주세요",
                    label: "비밀번호 확인",
                    text: $passwordConfirmationText
                )

                FINDAButton(
                    buttonText: "비밀번호 변경",
                    isDisabled: true,
                    buttonClick: {  }
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
    NewPasswordView(passwordText: .constant(""), passwordConfirmationText: .constant(""))
}
