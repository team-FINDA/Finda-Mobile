#if !SKIP
import SwiftUI
import DesignSystem

struct NoticeAlertListCell: View {
    var title: String
    var date: String
    var time: String
    var action: () -> Void

    init(
        title: String,
        date: String,
        time: String,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.date = date
        self.time = time
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image.Icons.notification
                    .padding(8)
                    .background(Color.Blue.blue10)
                    .clipShape(.rect(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.finda(.body1))
                        .foregroundStyle(Color.Gray.gray90)

                    HStack(spacing: 8) {
                        Text(date)
                            .font(.finda(.body4))
                            .foregroundStyle(Color.Gray.gray70)

                        Text(time)
                            .font(.finda(.body4))
                            .foregroundStyle(Color.Gray.gray70)
                    }
                }

                Spacer()
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 16)
            .background(Color.Gray.gray10)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NoticeAlertListCell(title: "꽃에 물주러 오세요", date: "2025.06.30", time: "13:00")
}

#endif
