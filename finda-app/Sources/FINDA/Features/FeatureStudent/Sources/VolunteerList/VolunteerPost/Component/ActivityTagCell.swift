import SwiftUI

struct ActivityTagCell: View {
    let title: String

    var body: some View {
        Group {
            Text(title)
                .font(.finda(.caption1))
                .foregroundColor(.blue40)
                .padding(.horizontal, 7)
                .padding(.vertical, 8)
                .background(Color.blue10)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.blue50, lineWidth: 0.5)
                }
        }
    }
}

struct ActivityTagSection: View {
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("활동")
                .font(.finda(.caption1))
                .foregroundColor(.gray60)
            TagFlowView(tags: tags)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TagFlowView: View {
    let tags: [String]
    let spacing: CGFloat = 8

    private func chunked(_ array: [String], size: Int) -> [[String]] {
        stride(from: 0, to: array.count, by: size).map {
            Array(array[$0..<min($0 + size, array.count)])
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            ForEach(Array(chunked(tags, size: 3).enumerated()), id: \.offset) { _, row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { tag in
                        ActivityTagCell(title: tag)
                    }
                    Spacer()
                }
            }
        }
    }
}
