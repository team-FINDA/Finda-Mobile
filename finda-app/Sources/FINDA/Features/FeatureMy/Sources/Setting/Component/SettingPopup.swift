import SwiftUI

struct SettingPopup: View {
    var title: String
    var content: String
    var cancelAction: () -> Void
    var okAction: () -> Void

    init(
        title: String,
        content: String,
        cancelAction: @escaping () -> Void = {},
        okAction: @escaping () -> Void = {}
    ) {
        self.title = title
        self.content = content
        self.cancelAction = cancelAction
        self.okAction = okAction
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.finda(.subheading2))
                .foregroundStyle(Color.red20)

            Text(content)
                .font(.finda(.body4))
                .foregroundStyle(Color.gray60)
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Button(action: cancelAction) {
                    Text("취소")
                        .font(.finda(.body3))
                        .foregroundStyle(Color.gray60)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .background(Color.gray30, in: RoundedRectangle(cornerRadius: 5))

                Button(action: okAction) {
                    Text(title)
                        .font(.finda(.body3))
                        .foregroundStyle(Color.red20)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .background(Color.red10, in: RoundedRectangle(cornerRadius: 5))
            }
        }
        .padding(20)
        .background(Color.gray10, in: RoundedRectangle(cornerRadius: 10))
    }
}
