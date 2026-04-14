import SwiftUI

struct HistoryListCell: View {
    var title: String
    var date: String
    var time: Float

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.finda(.body3))
                    .foregroundStyle(Color.gray90)
                Text(date)
                    .font(.finda(.caption2))
                    .foregroundStyle(Color.gray50)
            }
            Spacer()
            Text("+ \(String(format: "%.1f", time))시간")
                .font(.finda(.body3))
                .foregroundStyle(Color.blue50)
        }
        .padding(20)
        .background(Color.gray20)
        .cornerRadius(10)
    }
}
