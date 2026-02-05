import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SecretKeyView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<SecretKeyFeature>

    init(store: StoreOf<SecretKeyFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
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
                        text: $store.secretKeyText
                    )
                    FINDAButton(
                        buttonText: "다음",
                        isDisabled: store.signupButtonIsDisable,
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
}

#Preview {
    SecretKeyView(
        store: Store(initialState: SecretKeyFeature.State()) {
            SecretKeyFeature()
        }
    )
}
