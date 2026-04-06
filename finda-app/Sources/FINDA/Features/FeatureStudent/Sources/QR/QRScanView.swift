import SwiftUI

public struct QRScanView: View {
    @State private var scannedURI: String = ""
    @State private var isShowingScanAlert = false

    public init() {}

    public var body: some View {
        #if !SKIP
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
        VStack(spacing: 20) {
            Image(systemName: "qrcode.viewfinder")
                .font(.system(size: 80))
                .foregroundColor(.gray50)
            Text("QR 스캔")
                .font(.finda(.heading4))
                .foregroundColor(.gray80)
            Text("카메라로 QR코드를 스캔해주세요")
                .font(.finda(.body3))
                .foregroundColor(.gray60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        #endif
    }
}

#if !SKIP
import UIKit
import AVFoundation

struct QRScannerRepresentable: UIViewControllerRepresentable {
    let isPopupPresented: Bool
    let onCodeScanned: (String) -> Void

    final class Coordinator {
        var wasPopupPresented = false
    }

    func makeCoordinator() -> Coordinator { Coordinator() }

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

final class QRScannerViewController: UIViewController, @preconcurrency AVCaptureMetadataOutputObjectsDelegate {
    var onCodeScanned: ((String) -> Void)?
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.finda.qr.capture-session")
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var lastScannedCode: String?
    private var isSessionConfigured = false
    private weak var cameraPermissionAlert: UIAlertController?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureCameraSession()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sessionQueue.async { [weak self] in
            guard let self, self.captureSession.isRunning else { return }
            self.captureSession.stopRunning()
        }
    }

    private func configureCameraSession() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            dismissCameraPermissionAlertIfNeeded()
            sessionQueue.async { [weak self] in self?.setupSessionAndStart() }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    self?.sessionQueue.async { self?.setupSessionAndStart() }
                } else {
                    DispatchQueue.main.async { self?.presentCameraPermissionAlertIfNeeded() }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async { [weak self] in self?.presentCameraPermissionAlertIfNeeded() }
        @unknown default:
            return
        }
    }

    private func presentCameraPermissionAlertIfNeeded() {
        guard cameraPermissionAlert == nil else { return }
        let alert = UIAlertController(
            title: "카메라 권한이 필요해요",
            message: "QR 스캔을 위해 카메라 접근 권한을 허용해주세요.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel) { [weak self] _ in self?.cameraPermissionAlert = nil })
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { [weak self] _ in
            self?.cameraPermissionAlert = nil
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(url)
        })
        cameraPermissionAlert = alert
        present(alert, animated: true)
    }

    private func dismissCameraPermissionAlertIfNeeded() {
        guard let alert = cameraPermissionAlert else { return }
        cameraPermissionAlert = nil
        guard presentedViewController === alert else { return }
        alert.dismiss(animated: true)
    }

    private func setupSessionAndStart() {
        if isSessionConfigured { startSessionIfNeeded(); return }
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            if captureSession.canAddInput(input) { captureSession.addInput(input) }
            let output = AVCaptureMetadataOutput()
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
                output.setMetadataObjectsDelegate(self, queue: .main)
                guard output.availableMetadataObjectTypes.contains(.qr) else { return }
                output.metadataObjectTypes = [.qr]
            }
            let preview = AVCaptureVideoPreviewLayer(session: captureSession)
            preview.videoGravity = .resizeAspectFill
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                preview.frame = self.view.bounds
                self.view.layer.insertSublayer(preview, at: 0)
                self.previewLayer = preview
            }
            isSessionConfigured = true
            startSessionIfNeeded()
        } catch { return }
    }

    private func startSessionIfNeeded() {
        sessionQueue.async { [weak self] in
            guard let self, !self.captureSession.isRunning else { return }
            self.captureSession.startRunning()
        }
    }

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let readableObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let code = readableObject.stringValue else { return }
        guard lastScannedCode != code else { return }
        lastScannedCode = code
        onCodeScanned?(code)
    }

    func resetLastScannedCode() { lastScannedCode = nil }
}
#endif
