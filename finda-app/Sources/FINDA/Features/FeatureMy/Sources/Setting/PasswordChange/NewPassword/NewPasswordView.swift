#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

struct NewPasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable private var store: StoreOf<NewPasswordFeature>
    private let selectedRole: UserRole?

    init(
        store: StoreOf<NewPasswordFeature>,
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
                        FINDAImage("leftArrow")
                            .foregroundStyle(Color.gray80)
                    })
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 8)

                ViewThatFits(in: .vertical) {
                    Text("비밀번호 변경")
                        .font(.finda(.heading4))
                        .foregroundStyle(Color.gray80)
                        .padding(.bottom, 64)
                }

                VStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 4) {
                        AuthTextField(
                            type: .password,
                            placeholder: "비밀번호를 입력해주세요",
                            text: $store.passwordText
                        )
                        Text("비밀번호는 이런이런이런 형식으로 ㄱㄱ")
                            .font(.finda(.body4))
                            .foregroundStyle(Color.blue50)
                    }
                    AuthTextField(
                        type: .password,
                        placeholder: "비밀번호를 다시 입력해주세요",
                        label: "비밀번호 확인",
                        text: $store.passwordConfirmText
                    )

                    FINDAButton(
                        buttonText: "비밀번호 변경",
                        isDisabled: store.passwordChangeButtonIsDisabled,
                        buttonClick: { store.send(.passwordChangeButtonTapped) }
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
    NewPasswordView(
        store: Store(initialState: NewPasswordFeature.State()) {
            NewPasswordFeature()
        },
        selectedRole: .student
    )
}

#endif
