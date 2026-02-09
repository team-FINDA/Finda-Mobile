import SwiftUI

public struct FINDAButton: View {
    let buttonText: String
    var buttonColor: Color
    var isDisabled: Bool
    var action: (() -> Void)

    public init(
        buttonText: String,
        buttonColor: Color = Color.Blue.blue50,
        isDisabled: Bool = false,
        buttonClick: @escaping (() -> Void)
    ) {
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.isDisabled = isDisabled
        self.action = buttonClick
    }

    public var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .font(.finda(.button))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 17)
                .foregroundStyle(Color.Gray.gray10)
        }
        .disabled(isDisabled)
        .background(isDisabled ? Color.Gray.gray40 : buttonColor)
        .cornerRadius(32)
    }
}

#Preview {
    FINDAButton(
        buttonText: "다음",
        isDisabled: false,
        buttonClick: {}
    )
}
