import SwiftUI

struct ActivityTagCell: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.finda(.caption1))
            .foregroundColor(.blue40)
            .padding(.horizontal, 7)
            .padding(.vertical, 8)
            .background(Capsule().fill(Color.blue10))
            .overlay(Capsule().strokeBorder(Color.blue50, lineWidth: 0.5))
    }
}

struct ActivityTagSection: View {
    let tags: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("활동")
                .font(.finda(.caption1))
                .foregroundColor(.gray60)

            // Skip 호환 FlowLayout 대체 구현
            TagFlowView(tags: tags)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct TagFlowView: View {
    let tags: [String]
    let spacing: CGFloat = 8

    // 태그를 행별로 나누기 위해 고정 너비 기준으로 그룹핑
    // Skip에서 GeometryReader 기반 동적 플로우는 제한적이므로
    // 단순히 HStack wrap 방식으로 처리
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
