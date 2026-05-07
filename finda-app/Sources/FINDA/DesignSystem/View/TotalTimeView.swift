import SwiftUI

public struct TotalTimeView: View {
    var volunteerTime: Double

    public init(volunteerTime: Double) {
        self.volunteerTime = volunteerTime
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("총 봉사 시간")
                    .font(.finda(.body3))
                    .foregroundStyle(Color.gray60)

                Text("\(oneDecimalString(volunteerTime)) 시간")
                    .font(.finda(.heading2))
                    .foregroundStyle(Color.gray90)
            }
            Spacer()
        }
        .padding(24)
        .background(Color.gray20)
        .cornerRadius(20)
    }

    private func oneDecimalString(_ value: Double) -> String {
        let scaled = Int((value * 10).rounded())
        let integerPart = scaled / 10
        let decimalPart = abs(scaled % 10)
        return "\(integerPart).\(decimalPart)"
    }
}

#Preview {
    TotalTimeView(volunteerTime: 100)
}
