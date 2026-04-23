import SwiftUI

struct SigninUserSelectView: View {
    var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 64) {
            Text("로그인")
                .font(.finda(.heading4))
                .foregroundStyle(Color.gray80)
                .padding(.top, 40)

            VStack(spacing: 40) {
                UserSelectButton(
                    icon: FINDAImage("pencil"),
                    text: "학생 로그인",
                    action: { viewModel.studentSigninTapped() }
                )
                UserSelectButton(
                    icon: FINDAImage("book"),
                    text: "선생님 로그인",
                    action: { viewModel.teacherSigninTapped() }
                )
                AuthPromptButton(
                    promptText: "계정이 없으신가요?",
                    buttonText: "회원가입",
                    action: { viewModel.signupTapped() }
                )
            }
            .padding(.horizontal, 24)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
