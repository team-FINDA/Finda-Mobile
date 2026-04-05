#if !SKIP
import SwiftUI
import DesignSystem

struct QRPage: Identifiable {
    let id: String
    let title: String
}

struct QRCodeView: View {
    let page: QRPage
    let onGenerateButtonTapped: (String) -> Void
    @State private var pulseAnimation = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.Blue.blue10)

            GeometryReader { geo in
                Path { path in
                    path.move(to: CGPoint(x: geo.size.width / 2, y: 0))
                    path.addLine(to: CGPoint(x: geo.size.width / 2, y: geo.size.height))
                }
                .stroke(Color.Blue.blue40, lineWidth: 0.3)

                Path { path in
                    path.move(to: CGPoint(x: 0, y: geo.size.height / 2))
                    path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height / 2))
                }
                .stroke(Color.Blue.blue40, lineWidth: 0.3)
            }
            .padding(16)
            .clipShape(RoundedRectangle(cornerRadius: 24))

            Button {
                onGenerateButtonTapped(page.id)
            } label: {
                Text("QR 생성하기")
                    .font(.finda(.body3))
                    .foregroundColor(.Blue.blue10)
                .padding(.horizontal, 27)
                .padding(.vertical, 14)
                .background(
                    Capsule()
                        .fill(Color.Blue.blue50)
                )
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
                    .fill(index == current ? Color.Blue.blue50 : Color.Blue.blue10)
                    .frame(
                        width: index == current ? 7 : 6,
                        height: index == current ? 7 : 6
                    )
                    .animation(.spring(response: 0.3), value: current)
            }
        }
    }
}

struct QRListView: View {
    let pages: [QRPage]
    let onGenerateRequest: (String) -> Void
    @State private var currentPage = 0

    init(
        pages: [QRPage],
        onGenerateRequest: @escaping (String) -> Void = { _ in }
    ) {
        self.pages = pages
        self.onGenerateRequest = onGenerateRequest
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if pages.indices.contains(currentPage) {
                Text(pages[currentPage].title)
                    .font(.finda(.subheading2))
                    .foregroundColor(.Gray.gray90)
                    .padding(.bottom, 12)
                    .id(currentPage)
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing).combined(with: .opacity),
                        removal: .move(edge: .leading).combined(with: .opacity)
                    ))
            }

            TabView(selection: $currentPage) {
                ForEach(Array(pages.enumerated()), id: \.element.id) { index, page in
                    QRCodeView(
                        page: page,
                        onGenerateButtonTapped: { selectedPageID in
                            onGenerateRequest(selectedPageID)
                        }
                    )
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)

            HStack {
                Spacer()
                PageIndicator(total: pages.count, current: currentPage)
                Spacer()
            }
            .padding(.top, 12)
        }
    }
}

#Preview {
    QRListView(
        pages: [
            QRPage(id: "1231231", title: "환경지킴이"),
            QRPage(id: "3543453", title: "바둑두기"),
            QRPage(id: "7867656", title: "화분에 물주기")
        ]
    )
}

#endif
