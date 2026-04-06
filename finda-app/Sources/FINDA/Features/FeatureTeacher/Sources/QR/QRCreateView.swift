#if !SKIP && canImport(UIKit)
import SwiftUI

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
    }
}

#Preview {
    QRCreateView()
}

#endif
