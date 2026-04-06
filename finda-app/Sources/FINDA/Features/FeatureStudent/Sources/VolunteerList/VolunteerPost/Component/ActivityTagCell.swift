#if !SKIP && canImport(UIKit)
import SwiftUI

struct ActivityTagCell: View {
    let title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.finda(.caption1))
            .foregroundColor(.blue40)
            .padding(.horizontal, 7)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.blue10)
            )
            .overlay(
                Capsule()
                    .strokeBorder(Color.blue50, lineWidth: 0.5)
            )
    }
}

struct ActivityTagFlowLayout: Layout {
    var spacing: CGFloat = 12
    var rowSpacing: CGFloat = 12

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        let maxWidth = proposal.width ?? .greatestFiniteMagnitude
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var rowHeight: CGFloat = 0
        var usedWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentX > 0 && currentX + size.width > maxWidth {
                usedWidth = max(usedWidth, currentX - spacing)
                currentX = 0
                currentY += rowHeight + rowSpacing
                rowHeight = 0
            }

            rowHeight = max(rowHeight, size.height)
            currentX += size.width + spacing
            usedWidth = max(usedWidth, currentX - spacing)
        }

        let totalHeight = subviews.isEmpty ? 0 : currentY + rowHeight
        return CGSize(width: proposal.width ?? usedWidth, height: totalHeight)
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let maxWidth = bounds.width
        var currentX = bounds.minX
        var currentY = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if currentX > bounds.minX && currentX + size.width > bounds.minX + maxWidth {
                currentX = bounds.minX
                currentY += rowHeight + rowSpacing
                rowHeight = 0
            }

            subview.place(
                at: CGPoint(x: currentX, y: currentY),
                proposal: ProposedViewSize(size)
            )

            currentX += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

struct ActivityTagSection: View {
    let tags: [String]

    init(tags: [String]) {
        self.tags = tags
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("활동")
                .font(.finda(.caption1))
                .foregroundColor(.gray60)

            ActivityTagFlowLayout(spacing: 8, rowSpacing: 8) {
                ForEach(tags, id: \.self) { tag in
                    ActivityTagCell(title: tag)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ActivityTagSection(
        tags: ["교장실", "상담실 분리수거", "제2 교무실", "제3 교무실", "청죽관 분리수거", "교실 분리수거"]
    )
    .padding()
}

#endif
