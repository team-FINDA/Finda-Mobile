import SwiftUI

public struct UserSelectButton: View {
    let icon: Image
    let text: String
    let action: () -> Void

    public init(icon: Image, text: String, action: @escaping () -> Void) {
        self.icon = icon
        self.text = text
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            VStack(spacing: 20) {
                icon

                Text(text)
                    .font(.finda(.subheading2))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 36)
            .background(Color.blue10, in: RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    UserSelectButton(
        icon: FINDAImage("pencil"),
        text: "학생 로그인",
        action: {}
    )
    UserSelectButton(
        icon: FINDAImage("book"),
        text: "학생 로그인",
        action: {}
    )
}
