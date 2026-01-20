import SwiftUI

public struct FINDAButton: View {
    let buttonText: String
    var buttonColor: Color
    var isDisabled: Bool
    var buttonClick: (() -> Void)

    public init(
        buttonText: String,
        buttonColor: Color = DesignSystemAsset.Blue.blue50.swiftUIColor,
        isDisabled: Bool = false,
        buttonClick: @escaping (() -> Void)
    ) {
        self.buttonText = buttonText
        self.buttonColor = buttonColor
        self.isDisabled = isDisabled
        self.buttonClick = buttonClick
    }

    public var body: some View {
        Button {
            buttonClick()
        } label: {
            Text(buttonText)
                .font(.finda(.button))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 17)
                .foregroundStyle(DesignSystemAsset.Gray.gray10.swiftUIColor)
        }
        .disabled(isDisabled)
        .background(isDisabled ? DesignSystemAsset.Gray.gray40.swiftUIColor : buttonColor)
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
