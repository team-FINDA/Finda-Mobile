import SwiftUI

public struct QRScanView: View {
    @State private var scannedURI: String = ""
    @State private var isShowingScanAlert = false

    public init() {}

    public var body: some View {
        ZStack {
            QRScannerRepresentable { code in
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
