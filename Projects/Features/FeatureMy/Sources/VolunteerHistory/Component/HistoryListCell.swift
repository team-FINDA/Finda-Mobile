import SwiftUI
import DesignSystem
import Foundation

struct HistoryListCell: View {
    var title: String
    var date: String
    var time: Double

    init(
        title: String,
        date: String,
        time: Double
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

            Text("+ \(oneDecimalString(time))시간")
                .font(.finda(.body3))
                .foregroundStyle(Color.Blue.blue50)
        }
        .padding(20)
        .background(Color.Gray.gray20)
        .clipShape(.rect(cornerRadius: 10))
    }

    private func oneDecimalString(_ value: Double) -> String {
        let scaled = Int((value * 10).rounded())
        let integerPart = scaled / 10
        let decimalPart = abs(scaled % 10)
        return "\(integerPart).\(decimalPart)"
    }
}

#Preview {
    HistoryListCell(
        title: "환경지킴이",
        date: "2025.12.28",
        time: 2
    )
}
