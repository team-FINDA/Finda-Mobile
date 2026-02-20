import SwiftUI

public struct QRScanView: View {
    // 최근에 읽은 QR 문자열(알럿 메시지에 표시)
    @State private var scannedURI: String = ""
    // 스캔 완료 알럿 표시 상태
    @State private var isShowingScanAlert = false

    public init() {}

    public var body: some View {
        ZStack {
            // UIKit 기반 QR 스캐너를 SwiftUI 뷰에 임베드
            QRScannerRepresentable { code in
                // 알럿이 떠 있는 동안에는 중복 처리 방지
                guard !isShowingScanAlert else { return }
                scannedURI = code
                isShowingScanAlert = true
            }
            .ignoresSafeArea()
        }
        .alert("QR 인식 완료", isPresented: $isShowingScanAlert) {
            Button("확인", role: .cancel) {}
        } message: {
            Text(scannedURI)
        }
    }
}
