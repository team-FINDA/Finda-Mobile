import SwiftUI
import DesignSystem

public struct SigninUserSelectView: View {
    public init() {}
    public var body: some View {
        VStack(spacing: 64) {
            Text("로그인")
                .font(.finda(.heading4))
                .foregroundStyle(Color.Gray.gray80)
                .padding(.top, 64)

            VStack(spacing: 40) {
                UserSelectButton(
                    icon: Image.Images.pencil,
                    text: "학생 로그인",
                    action: {}
                )
                UserSelectButton(
                    icon: Image.Images.book,
                    text: "선생님 로그인",
                    action: {}
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
    }
}

#Preview {
    SigninUserSelectView()
}
