import SwiftUI

struct StudentListCell: View {
    var name: String
    var state: Bool

    var body: some View {
        HStack {
            Text(name)
                .font(.finda(.body1))
                .foregroundColor(.gray90)

            Spacer()

            Text(state ? "출석" : "미출석")
                .font(.finda(.caption1))
                .foregroundColor(state ? .green20 : .red20)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(state ? Color.green10 : Color.red10)
                .cornerRadius(40)
        }
        .padding(16)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(state ? Color.green20 : Color.red20, lineWidth: 0.8)
        )
    }
}
