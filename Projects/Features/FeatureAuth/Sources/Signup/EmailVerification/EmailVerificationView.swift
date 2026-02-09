import SwiftUI
import ComposableArchitecture
import DesignSystem

struct EmailVerificationView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<EmailVerificationFeature>

    init(store: StoreOf<EmailVerificationFeature>) {
        self.store = store
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
                    type: .verificationEmail,
                    placeholder: "이메일을 입력해주세요",
                    text: $store.emailText
                )
                AuthTextField(
                    type: .base,
                    placeholder: "인증 코드를 입력해주세요",
                    label: "인증 코드",
                    text: $store.codeText
                )

                FINDAButton(
                    buttonText: "다음",
                    isDisabled: store.nextButtonIsDisable,
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
    EmailVerificationView(
        store: Store(initialState: EmailVerificationFeature.State()) {
            EmailVerificationFeature()
        }
    )
}
