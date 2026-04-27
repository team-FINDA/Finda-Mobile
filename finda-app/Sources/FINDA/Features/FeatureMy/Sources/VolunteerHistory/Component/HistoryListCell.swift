import SwiftUI

struct HistoryListCell: View {
    var title: String
    var date: String
    var time: Double

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
            Text("+ \(oneDecimalString(time))시간")
                .font(.finda(.body3))
                .foregroundStyle(Color.blue50)
        }
        .padding(20)
        .background(Color.gray20)
        .cornerRadius(10)
    }

    private func oneDecimalString(_ value: Double) -> String {
        let scaled = Int((value * 10).rounded())
        let integerPart = scaled / 10
        let decimalPart = abs(scaled % 10)
        return "\(integerPart).\(decimalPart)"
    }
}
