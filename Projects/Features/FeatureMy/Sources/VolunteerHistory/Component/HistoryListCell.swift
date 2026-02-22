import SwiftUI
import DesignSystem
import Foundation

struct HistoryListCell: View {
    var title: String
    var date: String
    var time: Float

    init(
        title: String,
        date: String,
        time: Float
    ) {
        self.title = title
        self.date = date
        self.time = time
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.finda(.body3))
                    .foregroundStyle(Color.Gray.gray90)

                Text(date)
                    .font(.finda(.caption2))
                    .foregroundStyle(Color.Gray.gray50)
            }

            Spacer()

            Text("+ \(String(format: "%.1f", time))시간")
                .font(.finda(.body3))
                .foregroundStyle(Color.Blue.blue50)
        }
        .padding(20)
        .background(Color.Gray.gray20)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    HistoryListCell(
        title: "환경지킴이",
        date: "2025.12.28",
        time: 2
    )
}
