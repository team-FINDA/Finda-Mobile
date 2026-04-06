import SwiftUI

struct PasswordChangeEmailVerificationView: View {
    @Environment(\.dismiss) private var dismiss
    let role: UserRole
    let onNextTapped: () -> Void
    @State private var emailText = ""
    @State private var codeText = ""

    var isDisabled: Bool { emailText.isEmpty || codeText.isEmpty }

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
                AuthTextField(
                    type: role == .student ? .schoolVerificationEmail : .verificationEmail,
                    placeholder: role == .student ? "example" : "이메일을 입력해주세요",
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
                    buttonClick: { onNextTapped() }
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
