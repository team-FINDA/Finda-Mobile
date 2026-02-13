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
                    .font(.finda(.body3))
                    .foregroundColor(.Gray.gray90)
                Text(date)
                    .font(.finda(.caption4))
                    .foregroundColor(.Gray.gray80)
            }

            Spacer()

            Text("\(time)시간")
                .font(.finda(.caption1))
                .foregroundColor(.Blue.blue40)
        }
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.Gray.gray40, lineWidth: 0.8)
        )
    }
}

#Preview {
    VolunteerListCell(
        volunteerName: "환경직킴이",
        date: "2025/04/16 ~ 2025/07/30",
        time: 8
    )
}
