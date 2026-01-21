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
            .padding(.vertical, 32)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(DesignSystemAsset.Blue.blue10.swiftUIColor)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.15), value: configuration.isPressed)
    }
}

#Preview {
    UserSelectButton(
        icon: DesignSystemAsset.Images.pencil.swiftUIImage,
        text: "학생 로그인",
        action: {}
    )
    UserSelectButton(
        icon: DesignSystemAsset.Images.book.swiftUIImage,
        text: "학생 로그인",
        action: {}
    )
}
