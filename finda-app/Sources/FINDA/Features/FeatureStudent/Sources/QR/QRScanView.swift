import Foundation
import SwiftUI
#if canImport(AVFoundation)
import AVFoundation
#endif
#if SKIP
import android.webkit.WebView
import android.webkit.WebViewClient
import android.webkit.WebChromeClient
import androidx.compose.ui.viewinterop.AndroidView
#endif

private enum QRWebConfig {
    static let resultTitle = "출석 결과"
    static let successMessage = "출석이 완료되었습니다."
    static let failureMessage = "출석 처리에 실패했습니다."
}

public struct QRScanView: View {
    @State private var isLoading = false
    @State private var resultMessage = ""
    @State private var isResultPresented = false
    @State private var hasCameraPermission = false

    public init() {}

    public var body: some View {
        ZStack {
            if isAndroid || hasCameraPermission {
                scannerSurface
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Color.gray10
            }

            if isLoading {
                Color.black.opacity(0.4).ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(.circular)
                    .tint(.white)
            }

            if isResultPresented {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                ConfirmPopupView(
                    title: QRWebConfig.resultTitle,
                    content: resultMessage,
                    action: { isResultPresented = false }
                )
                .padding(.horizontal, 64)
            }
        }
        .onAppear {
            refreshCameraPermissionState()
            requestCameraPermissionIfNeeded()
        }
    }

    @ViewBuilder
    private var scannerSurface: some View {
        #if SKIP
        QRScannerAndroidWebView()
        #elseif canImport(WebKit) && canImport(UIKit)
        QRScannerWebViewRepresentable { qrValue, completion in
            handleScannedResult(qrValue, completion: completion)
        }
        #else
        Color.gray10
        #endif
    }

    private var isAndroid: Bool {
        #if SKIP
        return true
        #else
        return false
        #endif
    }

    private func refreshCameraPermissionState() {
        #if canImport(AVFoundation)
        hasCameraPermission = AVCaptureDevice.authorizationStatus(for: .video) == .authorized
        #else
        hasCameraPermission = true
        #endif
    }

    private func requestCameraPermissionIfNeeded() {
        #if canImport(AVFoundation)
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            hasCameraPermission = true
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    hasCameraPermission = granted
                }
            }
        default:
            hasCameraPermission = false
        }
        #endif
    }

    private func handleScannedResult(_ qrValue: String, completion: @escaping (Bool, String) -> Void) {
        isLoading = true
        Task { @MainActor in
            defer { isLoading = false }
            let success = !qrValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let message = success ? QRWebConfig.successMessage : QRWebConfig.failureMessage
            completion(success, message)
            resultMessage = message
            isResultPresented = true
        }
    }
}

#if SKIP
private struct QRScannerAndroidWebView: View {
    var body: some View {
        ComposeView { context in
            AndroidView(factory: { ctx in
                let webView = WebView(ctx)
                configureAndroidWebView(webView)
                webView.loadUrl(WebViewEndpoints.qrScanURL)
                return webView
            }, modifier: context.modifier, update: { _ in
            })
        }
    }

    private func configureAndroidWebView(_ webView: WebView) {
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.settings.mediaPlaybackRequiresUserGesture = false
        webView.settings.allowContentAccess = true
        webView.settings.allowFileAccess = true
        webView.webChromeClient = WebChromeClient()
        webView.webViewClient = WebViewClient()
    }
}
#endif

#if canImport(WebKit) && canImport(UIKit)
import UIKit
import WebKit

struct QRScannerWebViewRepresentable: UIViewRepresentable {
    typealias Callback = (_ qrValue: String, _ complete: @escaping (Bool, String) -> Void) -> Void
    let onScanned: Callback

    func makeCoordinator() -> Coordinator { Coordinator(onScanned: onScanned) }

    func makeUIView(context: Context) -> WKWebView {
        let contentController = WKUserContentController()
        contentController.add(context.coordinator, name: "IOSQR")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        if let url = URL(string: WebViewEndpoints.qrScanURL), !WebViewEndpoints.qrScanURL.isEmpty {
            webView.load(URLRequest(url: url))
        }
        context.coordinator.webView = webView
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

final class Coordinator: NSObject, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    private let onScanned: QRScannerWebViewRepresentable.Callback
    weak var webView: WKWebView?

    init(onScanned: @escaping QRScannerWebViewRepresentable.Callback) {
        self.onScanned = onScanned
    }

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "IOSQR",
              let body = message.body as? [String: Any],
              body["type"] as? String == "QR_SCAN_SUCCESS",
              let qrValue = body["value"] as? String else { return }

        onScanned(qrValue) { [weak self] success, resultMessage in
            let safeMessage = resultMessage
                .replacingOccurrences(of: "\\", with: "\\\\")
                .replacingOccurrences(of: "\"", with: "\\\"")
            let script = """
            window.QRScannerWebView?.showResult({
              success: \(success ? "true" : "false"),
              message: "\(safeMessage)"
            })
            """
            self?.webView?.evaluateJavaScript(script)
        }
    }

    @available(iOS 15.0, *)
    func webView(
        _ webView: WKWebView,
        requestMediaCapturePermissionFor origin: WKSecurityOrigin,
        initiatedByFrame frame: WKFrameInfo,
        type: WKMediaCaptureType,
        decisionHandler: @escaping (WKPermissionDecision) -> Void
    ) {
        decisionHandler(.grant)
    }
}
#endif
