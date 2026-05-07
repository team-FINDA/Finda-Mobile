import SwiftUI

public struct AuthPromptButton: View {
    let promptText: String
    let buttonText: String
    let action: () -> Void

    public init(
        promptText: String,
        buttonText: String,
        action: @escaping () -> Void = {}
    ) {
        self.promptText = promptText
        self.buttonText = buttonText
        self.action = action
    }

    public var body: some View {
        HStack(spacing: 4) {
            Text(promptText)
                .font(.finda(.body4))
                .foregroundStyle(Color.gray60)
            Button(
                action: action
            ) {
                Text(buttonText)
                    .font(.finda(.body3))
                    .foregroundStyle(Color.gray80)
            }
        }
    }
}

#Preview {
    AuthPromptButton(
        promptText: "계정이 없으신가요?",
        buttonText: "회원가입",
        action: {}
    )
}
