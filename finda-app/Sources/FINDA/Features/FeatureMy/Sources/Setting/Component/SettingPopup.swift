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
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color.gray30)
                )

                Button(action: okAction) {
                    Text(title)
                        .font(.finda(.body3))
                        .foregroundStyle(Color.red20)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color.red10)
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.gray10)
        )
    }
}
