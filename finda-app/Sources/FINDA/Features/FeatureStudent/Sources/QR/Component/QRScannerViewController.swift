#if !SKIP && canImport(UIKit)
import UIKit
import AVFoundation

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
            sessionQueue.async { [weak self] in
                self?.setupSessionAndStart()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    self?.sessionQueue.async { [weak self] in
                        self?.setupSessionAndStart()
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presentCameraPermissionAlertIfNeeded()
                    }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async { [weak self] in
                self?.presentCameraPermissionAlertIfNeeded()
            }
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
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel) { [weak self] _ in
            self?.cameraPermissionAlert = nil
        })
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
        if isSessionConfigured {
            startSessionIfNeeded()
            return
        }

        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            let output = AVCaptureMetadataOutput()
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
                output.setMetadataObjectsDelegate(self, queue: .main)
                let availableTypes = output.availableMetadataObjectTypes
                guard availableTypes.contains(.qr) else { return }
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
        } catch {
            return
        }
    }

    private func startSessionIfNeeded() {
        sessionQueue.async { [weak self] in
            guard let self, !self.captureSession.isRunning else { return }
            self.captureSession.startRunning()
        }
    }

    func metadataOutput(
        _ output: AVCaptureMetadataOutput,
        didOutput metadataObjects: [AVMetadataObject],
        from connection: AVCaptureConnection
    ) {
        guard
            let readableObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
            let code = readableObject.stringValue
        else {
            return
        }

        guard lastScannedCode != code else { return }
        lastScannedCode = code
        onCodeScanned?(code)
    }

    func resetLastScannedCode() {
        lastScannedCode = nil
    }
}

#endif
