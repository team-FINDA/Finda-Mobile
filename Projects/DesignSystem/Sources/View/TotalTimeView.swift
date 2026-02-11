import SwiftUI

public struct TotalTimeView: View {
    var volunteerTime: Int

    public init(volunteerTime: Int) {
        self.volunteerTime = volunteerTime
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("총 봉사 시간")
                    .font(.finda(.body3))
                    .foregroundStyle(Color.Gray.gray60)

                Text("\(volunteerTime) 시간")
                    .font(.finda(.heading2))
                    .foregroundStyle(Color.Gray.gray90)
            }
            Spacer()
        }
        .padding(24)
        .background(Color.Gray.gray20)
        .cornerRadius(20)
    }
}

#Preview {
    TotalTimeView(volunteerTime: 100)
}
