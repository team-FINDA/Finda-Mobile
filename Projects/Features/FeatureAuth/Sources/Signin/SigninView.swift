import SwiftUI
import ComposableArchitecture
import DesignSystem

struct SigninView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<SigninFeature>

    init(store: StoreOf<SigninFeature>) {
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

                Text("로그인")
                    .font(.finda(.heading4))
                    .foregroundStyle(Color.Gray.gray80)
                    .padding(.bottom, 64)

                VStack(spacing: 32) {
                    VStack(spacing: 24) {
                        AuthTextField(
                            type: store.role == .student ? .schoolEmail : .base,
                            placeholder: "이메일을 입력해주세요",
                            text: $store.emailText
                        )
                        AuthTextField(
                            type: .password,
                            placeholder: "비밀번호를 입력해주세요",
                            text: $store.passwordText
                        )
                    }
                    FINDAButton(
                        buttonText: "로그인",
                        isDisabled: store.signinButtonIsDisabled,
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
            .dismissKeyboardOnTap()
            .navigationBarBackButtonHidden(true)
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    SigninView(
        store: Store(initialState: SigninFeature.State(role: .student)) {
            SigninFeature()
        }
    )
}
