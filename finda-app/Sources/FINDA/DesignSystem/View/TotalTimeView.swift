import SwiftUI

public struct TotalTimeView: View {
    var volunteerTime: Float

    public init(volunteerTime: Float) {
        self.volunteerTime = volunteerTime
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("총 봉사 시간")
                    .font(.finda(.body3))
                    .foregroundStyle(Color.gray60)

                Text("\(String(format: "%.1f", volunteerTime)) 시간")
                    .font(.finda(.heading2))
                    .foregroundStyle(Color.gray90)
            }
            Spacer()
        }
        .padding(24)
        .background(Color.gray20)
        .cornerRadius(20)
    }
}

#Preview {
    TotalTimeView(volunteerTime: 100)
}
