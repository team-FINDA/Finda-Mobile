#if !SKIP && canImport(UIKit)
import SwiftUI

struct SettingButton: View {
    var buttonText: String
    var textColor: Color?
    var action: () -> Void

    init(
        buttonText: String,
        textColor: Color? = Color.Sub.red20,
        action: @escaping () -> Void
    ) {
        self.buttonText = buttonText
        self.textColor = textColor
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(buttonText)
                    .font(.finda(.body1))
                    .foregroundStyle(textColor!)

                Spacer()

                Image.Icons.rightArrow
            }
            .padding(18)
            .background(Color.Gray.gray20)
            .clipShape(.rect(cornerRadius: 16))
        }
    }
}

#Preview {
    SettingButton(
        buttonText: "로그아웃",
        action: {}
    )
}

#endif
