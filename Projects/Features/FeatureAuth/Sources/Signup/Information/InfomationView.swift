import SwiftUI
import Shared
import ComposableArchitecture
import DesignSystem

struct InformationView: View {
    @Environment(\.dismiss) private var dismiss
    @Perception.Bindable private var store: StoreOf<InformationFeature>
    private let selectedRole: UserRole?

    init(
        store: StoreOf<InformationFeature>,
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
                    text: $store.nameText
                )
                VStack(alignment: .leading, spacing: 4) {
                    AuthTextField(
                        type: .password,
                        placeholder: "비밀번호를 입력해주세요",
                        text: $store.passwordText
                    )
                    Text("비밀번호는 이런이런이런 형식으로 ㄱㄱ")
                        .font(.finda(.body4))
                        .foregroundStyle(Color.Blue.blue50)
                }
                AuthTextField(
                    type: .password,
                    placeholder: "비밀번호를 다시 입력해주세요",
                    label: "비밀번호 확인",
                    text: $store.passwordConfirmText
                )

                FINDAButton(
                    buttonText: "회원가입",
                    isDisabled: store.signupButtonIsDisabled,
                    buttonClick: { store.send(.signupButtonTapped) }
                )
                AuthPromptButton(
                    promptText: "계정이 있으신가요?",
                    buttonText: "로그인",
                    action: { store.send(.signinButtonTapped) }
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
}

#Preview {
    InformationView(
        store: Store(initialState: InformationFeature.State()) {
            InformationFeature()
        },
        selectedRole: .student
    )
}
