import SwiftUI

struct NoticeAlertListCell: View {
    let title: String
    let date: String
    let time: String
    let action: () -> Void

    init(title: String, date: String, time: String, action: @escaping () -> Void = {}) {
        self.title = title
        self.date = date
        self.time = time
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                FINDAImage("notification")
                    .padding(8)
                    .background(Color.blue10)
                    .clipShape(.rect(cornerRadius: 8))

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.finda(.body1))
                        .foregroundStyle(Color.gray90)
                    HStack(spacing: 8) {
                        Text(date)
                            .font(.finda(.body4))
                            .foregroundStyle(Color.gray70)
                        Text(time)
                            .font(.finda(.body4))
                            .foregroundStyle(Color.gray70)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 16)
            .background(Color.gray10)
        }
        .buttonStyle(.plain)
    }
}
