#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

struct SigninUserSelectView: View {
    private let store: StoreOf<SigninUserSelectFeature>

    init(store: StoreOf<SigninUserSelectFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 64) {
                Text("로그인")
                    .font(.finda(.heading4))
                    .foregroundStyle(Color.gray80)
                    .padding(.top, 40)

                VStack(spacing: 40) {
                    UserSelectButton(
                        icon: FINDAImage("pencil"),
                        text: "학생 로그인",
                        action: { store.send(.studentSigninButtonTapped) }
                    )
                    UserSelectButton(
                        icon: FINDAImage("book"),
                        text: "선생님 로그인",
                        action: { store.send(.teacherSigninButtonTapped) }
                    )
                    AuthPromptButton(
                        promptText: "계정이 없으신가요?",
                        buttonText: "회원가입",
                        action: { store.send(.signupButtonTapped) }
                    )
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        SigninUserSelectView(
            store: Store(initialState: SigninUserSelectFeature.State()) {
                SigninUserSelectFeature()
            }
        )
    }
}

#endif
