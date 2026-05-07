import SwiftUI

struct SignupUserSelectView: View {
    var viewModel: AuthViewModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Button(action: { dismiss() }) {
                    FINDAImage("leftArrow")
                        .foregroundStyle(Color.gray80)
                }
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
                        action: { viewModel.studentSignupTapped() }
                    )
                    UserSelectButton(
                        icon: FINDAImage("book"),
                        text: "선생님 회원가입",
                        action: { viewModel.teacherSignupTapped() }
                    )
                    AuthPromptButton(
                        promptText: "계정이 있으신가요?",
                        buttonText: "로그인",
                        action: { viewModel.backToRoot() }
                    )
                }
                .padding(.horizontal, 24)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
