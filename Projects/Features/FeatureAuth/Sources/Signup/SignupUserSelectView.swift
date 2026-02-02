import SwiftUI
import DesignSystem

public struct SignupUserSelectView: View {
    public init() {}
    public var body: some View {
        VStack(spacing: 64) {
            Text("회원가입")
                .font(.finda(.heading4))
                .foregroundStyle(Color.Gray.gray80)
                .padding(.top, 64)

            VStack(spacing: 40) {
                UserSelectButton(
                    icon: Image.Images.pencil,
                    text: "학생 회원가입",
                    action: {}
                )
                UserSelectButton(
                    icon: Image.Images.book,
                    text: "선생님 회원가입",
                    action: {}
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
    }
}

#Preview {
    SignupUserSelectView()
}
