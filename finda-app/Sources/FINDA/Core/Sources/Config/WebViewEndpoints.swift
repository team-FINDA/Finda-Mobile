import Foundation

enum WebViewEndpoints {
    private static let baseURLKey = "WEBVIEW_BASE_URL"
    private static let qrScanPathKey = "WEBVIEW_QR_SCAN_PATH"
    private static let qrDisplayPathKey = "WEBVIEW_QR_DISPLAY_PATH"
    private static let attendanceChartPathKey = "WEBVIEW_ATTENDANCE_CHART_PATH"

    static var baseURL: String { infoValue(for: baseURLKey) }
    static var qrScanURL: String { buildURL(path: infoValue(for: qrScanPathKey)) }
    static var qrDisplayURL: String { buildURL(path: infoValue(for: qrDisplayPathKey)) }
    static var attendanceChartURL: String { buildURL(path: infoValue(for: attendanceChartPathKey)) }

    private static func infoValue(for key: String) -> String {
        #if SKIP
        guard let context = ProcessInfo.processInfo.androidContext else { return "" }
        if let packageManager = context.getPackageManager(),
           let packageInfo = packageManager.getPackageInfo(
                context.getPackageName(),
                android.content.pm.PackageManager.GET_META_DATA
           ),
           let value = packageInfo.applicationInfo?.metaData?.getString(key) {
            return normalize(value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        }
        return ""
        #else
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else { return "" }
        return normalize(value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))
        #endif
    }

    private static func normalize(_ raw: String) -> String {
        raw.replacingOccurrences(of: ":/$()/", with: "://")
    }

    private static func buildURL(path: String) -> String {
        let base = baseURL.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let normalizedPath = path.hasPrefix("/") ? String(path.dropFirst()) : path
        guard !base.isEmpty, !normalizedPath.isEmpty else { return "" }
        return "\(base)/\(normalizedPath)"
    }
}
