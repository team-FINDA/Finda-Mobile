import SwiftUI

struct QRPage: Identifiable {
    let id: String
    let title: String
}

public struct QRCreateView: View {
    private let pages: [QRPage] = [
        QRPage(id: "1231231", title: "환경지킴이"),
        QRPage(id: "3543453", title: "바둑두기"),
        QRPage(id: "7867656", title: "화분에 물주기")
    ]
    @State private var selectedPageID: String?

    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("QR 코드 생성")
                    .font(.finda(.body1))
                    .foregroundColor(.gray90)
            }
            .padding(.vertical, 12)

            HStack(spacing: 10) {
                FINDAImage("logo")
                Text("학생이 QR을 찍으면\n자동으로 다른 QR로 변경됩니다!")
                    .font(.finda(.body4))
                    .foregroundColor(.gray90)
                Spacer()
            }
            .padding(15)
            .background(Color.blue10)
            .cornerRadius(10)

            QRListView(
                pages: pages,
                onGenerateRequest: { pageID in
                    selectedPageID = pageID
                }
            )

            Spacer()
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
    }
}

struct QRListView: View {
    let pages: [QRPage]
    let onGenerateRequest: (String) -> Void
    @State private var currentPage = 0

    init(pages: [QRPage], onGenerateRequest: @escaping (String) -> Void = { _ in }) {
        self.pages = pages
        self.onGenerateRequest = onGenerateRequest
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if pages.indices.contains(currentPage) {
                Text(pages[currentPage].title)
                    .font(.finda(.subheading2))
                    .foregroundColor(.gray90)
                    .padding(.bottom, 12)
            }

            #if !SKIP
            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                    QRCodeView(
                        page: page,
                        onGenerateButtonTapped: { onGenerateRequest($0) }
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            #else
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                        QRCodeView(
                            page: page,
                            onGenerateButtonTapped: { onGenerateRequest($0) }
                        )
                        .frame(width: 280, height: 280)
                        .onTapGesture { currentPage = index }
                    }
                }
                .padding(.horizontal, 24)
            }
            #endif

            HStack {
                Spacer()
                PageIndicator(total: pages.count, current: currentPage)
                Spacer()
            }
            .padding(.top, 12)
        }
    }
}

struct QRCodeView: View {
    let page: QRPage
    let onGenerateButtonTapped: (String) -> Void

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue10)

            Button {
                onGenerateButtonTapped(page.id)
            } label: {
                Text("QR 생성하기")
                    .font(.finda(.body3))
                    .foregroundColor(.blue10)
                    .padding(.horizontal, 27)
                    .padding(.vertical, 14)
                    .background(Capsule().fill(Color.blue50))
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

struct PageIndicator: View {
    let total: Int
    let current: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<total, id: \.self) { index in
                Circle()
                    .fill(index == current ? Color.blue50 : Color.blue10)
                    .frame(
                        width: index == current ? 7.0 : 6.0,
                        height: index == current ? 7.0 : 6.0
                    )
            }
        }
    }
}
