#if !SKIP && canImport(UIKit)
import SwiftUI
import ComposableArchitecture

struct SignupUserSelectView: View {
    private let store: StoreOf<SignupUserSelectFeature>
    @Environment(\.dismiss) private var dismiss

    init(store: StoreOf<SignupUserSelectFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 8) {
                HStack {
                    Button(action: { store.send(.backButtonTapped) }, label: {
                        FINDAImage("leftArrow")
                            .foregroundStyle(Color.gray80)
                    })
                    Spacer()
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)

                VStack(spacing: 64) {
                    Text("회원가입")
                        .font(.finda(.heading4))
                        .foregroundStyle(Color.gray80)

                    VStack(spacing: 40) {
                        UserSelectButton(
                            icon: FINDAImage("pencil"),
                            text: "학생 회원가입",
                            action: { store.send(.studentSignupButtonTapped) }
                        )
                        UserSelectButton(
                            icon: FINDAImage("book"),
                            text: "선생님 회원가입",
                            action: { store.send(.teacherSignupButtonTapped) }
                        )
                        AuthPromptButton(
                            promptText: "계정이 있으신가요?",
                            buttonText: "로그인",
                            action: { store.send(.signinButtonTapped) }
                        )
                    }
                    .padding(.horizontal, 24)
                }

                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        SignupUserSelectView(
            store: Store(initialState: SignupUserSelectFeature.State()) {
                SignupUserSelectFeature()
            }
        )
    }
}

#endif
