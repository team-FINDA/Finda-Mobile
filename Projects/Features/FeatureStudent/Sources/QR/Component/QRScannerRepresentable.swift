import SwiftUI

struct QRScannerRepresentable: UIViewControllerRepresentable {
    let isPopupPresented: Bool
    let onCodeScanned: (String) -> Void

    final class Coordinator {
        var wasPopupPresented = false
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIViewController(context: Context) -> QRScannerViewController {
        let controller = QRScannerViewController()
        controller.onCodeScanned = onCodeScanned
        return controller
    }

    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {
        if context.coordinator.wasPopupPresented && !isPopupPresented {
            uiViewController.resetLastScannedCode()
        }
        context.coordinator.wasPopupPresented = isPopupPresented
    }
}
