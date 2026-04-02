import SwiftUI

public struct ConfirmPopupView: View {
    var title: String
    var content: String
    var action: () -> Void

    public init(
        title: String,
        content: String,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.content = content
        self.action = action
    }

    public var body: some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Image.Icons.check

                Text(title)
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)

                Text(content)
                    .font(.finda(.caption2))
                    .foregroundColor(.Gray.gray80)
            }

            Button {
                action()
            } label: {
                Text("확인")
                    .font(.finda(.caption1))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .foregroundStyle(Color.Gray.gray10)
            }
            .background(Color.Blue.blue40)
            .cornerRadius(32)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.Gray.gray10)
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.Gray.gray80, lineWidth: 0.5)
        )
    }
}

#Preview {
    VStack {
        ConfirmPopupView(
            title: "신청 완료!",
            content: "봉사 활동 신청이 완료되었습니다.",
            action: {}
        )
    }.padding(.horizontal, 64)
}
