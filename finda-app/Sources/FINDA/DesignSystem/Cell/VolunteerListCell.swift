import SwiftUI

public struct VolunteerListCell: View {
    var volunteerName: String
    var date: String
    var time: Int

    public init(
        volunteerName: String,
        date: String,
        time: Int
    ) {
        self.volunteerName = volunteerName
        self.date = date
        self.time = time
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(volunteerName)
                    .font(.finda(.body1))
                    .foregroundColor(.gray90)
                Text(date)
                    .font(.finda(.caption2))
                    .foregroundColor(.gray80)
            }

            Spacer()

            Text("\(time)시간")
                .font(.finda(.body3))
                .foregroundColor(.blue40)
        }
        .padding(20)
        .overlay(alignment: .center) {
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.gray40, lineWidth: 0.8)
        }
    }
}

#Preview {
    VolunteerListCell(
        volunteerName: "환경직킴이",
        date: "2025/04/16 ~ 2025/07/30",
        time: 8
    )
}
