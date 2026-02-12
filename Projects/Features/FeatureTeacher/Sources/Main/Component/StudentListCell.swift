import SwiftUI

struct StudentListCell: View {
    var name: String
    var state: Bool

    init(name: String, state: Bool) {
        self.name = name
        self.state = state
    }

    var body: some View {
        HStack {
            Text(name)
                .font(.finda(.body1))
                .foregroundColor(.Gray.gray90)

            Spacer()

            Button(action: {}) {
                Text(state ? "출석" : "미출석")
                    .font(.finda(.caption1))
                    .foregroundColor(state ? .Sub.green20 : .Sub.red20)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
            }
            .background(state ? Color.Sub.green10 : Color.Sub.red10)
            .cornerRadius(40)
        }
        .padding(.vertical, 18)
        .padding(.horizontal, 16)
        .border(
            state ? Color.Sub.green20 : Color.Sub.red20,
            width: 0.5
        )
    }
}

#Preview {
    StudentListCell(name: "2216 하원", state: true)
}
