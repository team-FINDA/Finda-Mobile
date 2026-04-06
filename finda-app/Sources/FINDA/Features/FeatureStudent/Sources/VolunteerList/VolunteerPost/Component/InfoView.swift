#if !SKIP && canImport(UIKit)
import SwiftUI

struct InfoView: View {
    var icon: Image
    var title: String
    var content: String
    var date: Bool

    init(
        icon: Image,
        title: String,
        content: String,
        date: Bool = false
    ) {
        self.icon = icon
        self.title = title
        self.content = content
        self.date = date
    }

    var body: some View {
        VStack(alignment: .leading, spacing: date ? 8 : 12) {
            HStack(spacing: 5) {
                icon
                Text(title)
                    .font(.finda(.caption3))
                    .foregroundColor(.blue50)
            }

            Text(content)
                .lineLimit(nil)
                .font(.finda(date ? .caption1 : .body1))
                .foregroundColor(.gray90)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, minHeight: 56, alignment: .topLeading)
        .padding(14)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.gray70, lineWidth: 0.5)
        )
    }
}

#Preview {
    InfoView(icon: FINDAImage("calendar"), title: "신청 기간", content: "2025.3.10 ~2025.3.12")
}

#endif
