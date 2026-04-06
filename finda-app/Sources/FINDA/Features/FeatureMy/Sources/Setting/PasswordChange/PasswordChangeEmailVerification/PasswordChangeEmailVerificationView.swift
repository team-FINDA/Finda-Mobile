#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

struct PasswordChangeEmailVerificationView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<PasswordChangeEmailVerificationFeature>
    private let selectedRole: UserRole?

    init(
        store: StoreOf<PasswordChangeEmailVerificationFeature>,
        selectedRole: UserRole?
    ) {
        self.store = store
        self.selectedRole = selectedRole
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

                Text("비밀번호 변경")
                    .font(.finda(.heading4))
                    .foregroundStyle(Color.Gray.gray80)
                    .padding(.bottom, 64)

                VStack(spacing: 32) {
                    AuthTextField(
                        type: selectedRole == .student ? .schoolVerificationEmail : .verificationEmail,
                        placeholder: selectedRole == .student ? "example" : "이메일을 입력해주세요",
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
                        isDisabled: store.nextButtonIsDisabled,
                        buttonClick: { store.send(.nextButtonTapped) }
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
    PasswordChangeEmailVerificationView(
        store: Store(initialState: PasswordChangeEmailVerificationFeature.State()) {
            PasswordChangeEmailVerificationFeature()
        },
        selectedRole: .student
    )
}

#endif
