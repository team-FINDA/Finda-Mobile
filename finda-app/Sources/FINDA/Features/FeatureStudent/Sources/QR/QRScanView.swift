#if !SKIP && canImport(UIKit)
import SwiftUI

public struct QRScanView: View {
    @State private var scannedURI: String = ""
    @State private var isShowingScanAlert = false

    public init() {}

    public var body: some View {
        #if canImport(UIKit)
        ZStack {
            QRScannerRepresentable(isPopupPresented: isShowingScanAlert) { code in
                guard !isShowingScanAlert else { return }
                scannedURI = code
                isShowingScanAlert = true
            }
            .ignoresSafeArea()

            if isShowingScanAlert {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()

                ConfirmPopupView(
                    title: "QR 인식 완료",
                    content: scannedURI,
                    action: { isShowingScanAlert = false }
                )
                .padding(.horizontal, 64)
            }
        }
        #else
        Text("QR scanning is unavailable on this platform.")
        #endif
    }
}

#endif
