import SwiftUI
import DesignSystem

public struct QRCreateView: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("QR 코드 생성")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)
            }
            .padding(.vertical, 12)

            HStack(spacing: 10) {
                Image.Images.logo

                Text("학생이 QR을 찍으면\n자동으로 다른 QR로 변경됩니다!")
                    .font(.finda(.body4))
                    .foregroundColor(.Gray.gray90)

                Spacer()
            }
            .padding(15)
            .background(Color.Blue.blue10)
            .cornerRadius(10)

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    QRCreateView()
}
