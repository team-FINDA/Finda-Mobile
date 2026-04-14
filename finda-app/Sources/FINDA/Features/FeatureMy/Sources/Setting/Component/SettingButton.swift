import SwiftUI

struct SettingButton: View {
    var buttonText: String
    var textColor: Color
    var action: () -> Void

    init(
        buttonText: String,
        textColor: Color = Color.red20,
        action: @escaping () -> Void
    ) {
        self.buttonText = buttonText
        self.textColor = textColor
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack {
                Text(buttonText)
                    .font(.finda(.body1))
                    .foregroundStyle(textColor)
                Spacer()
                FINDAImage("rightArrow")
            }
            .padding(18)
            .background(Color.gray20)
            .cornerRadius(16)
        }
    }
}
