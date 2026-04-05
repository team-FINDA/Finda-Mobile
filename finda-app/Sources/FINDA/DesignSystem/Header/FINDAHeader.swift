import SwiftUI

public struct FINDAHeader: View {
    private let title: String
    private let leftItemImage: Image?
    private let leftItemAction: (() -> Void)?
    private let rightItemImage: Image?
    private let rightItemAction: (() -> Void)?

    public init(
        title: String,
        leftItemImage: Image? = nil,
        leftItemAction: (() -> Void)? = nil,
        rightItemImage: Image? = nil,
        rightItemAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.leftItemImage = leftItemImage
        self.leftItemAction = leftItemAction
        self.rightItemImage = rightItemImage
        self.rightItemAction = rightItemAction
    }

    public var body: some View {
        HStack {
            sideItem(image: leftItemImage, action: leftItemAction)

            Spacer()

            Text(title)
                .font(.finda(.body1))
                .foregroundColor(.gray90)

            Spacer()

            sideItem(image: rightItemImage, action: rightItemAction)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)
    }

    @ViewBuilder
    private func sideItem(image: Image?, action: (() -> Void)?) -> some View {
        if let image {
            if let action {
                Button(action: action) {
                    image
                }
            } else {
                image
            }
        } else {
            Color.clear
                .frame(width: 24, height: 24)
        }
    }
}

#Preview {
    FINDAHeader(
        title: "공지사항 관리",
        leftItemImage: Image("leftArrow"),
        leftItemAction: {},
        rightItemImage: Image("add"),
        rightItemAction: {}
    )
}
