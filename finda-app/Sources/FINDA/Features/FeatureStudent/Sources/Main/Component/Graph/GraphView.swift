import Foundation
import SwiftUI
#if SKIP
import android.webkit.WebView
import android.webkit.WebViewClient
import android.view.ViewGroup
import androidx.compose.ui.viewinterop.AndroidView
#elseif canImport(WebKit) && canImport(UIKit)
import UIKit
import WebKit
#endif

private struct AttendanceChartPoint: Codable {
    let month: String
    let value: Int
}

struct GraphView: View {
    private let title = "봉사활동 출석률"
    @State private var data: [AttendanceChartPoint] = []

    var body: some View {
        AttendanceChartWebContainer(title: title, data: data)
            .frame(height: 220)
            .background(Color.gray20)
            .cornerRadius(10)
            .clipped()
            .onAppear { loadData() }
    }

    private func loadData() {
#if SKIP
    android.util.Log.d("FINDA", "attendanceChartURL: \(WebViewEndpoints.attendanceChartURL)")
    #else
    print("🔍 attendanceChartURL: \(WebViewEndpoints.attendanceChartURL)")
    #endif
        let calendar = Calendar.current
        let now = Date()
        var points: [AttendanceChartPoint] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"

        for i in (0..<5).reversed() {
            if let date = calendar.date(byAdding: .month, value: -i, to: now) {
                points.append(
                    AttendanceChartPoint(
                        month: formatter.string(from: date),
                        value: Int.random(in: 0...100)
                    )
                )
            }
        }

        data = points
    }
}

private struct AttendanceChartWebContainer: View {
    let title: String
    let data: [AttendanceChartPoint]

    var body: some View {
        ZStack {
            platformWebView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    @ViewBuilder
    private var platformWebView: some View {
#if SKIP
        ComposeView { context in
            func chartURLString() -> String? {
                guard !WebViewEndpoints.attendanceChartURL.isEmpty,
                      let jsonData = try? JSONEncoder().encode(data),
                      let dataString = String(data: jsonData, encoding: .utf8) else {
                    return nil
                }

                return android.net.Uri.parse(WebViewEndpoints.attendanceChartURL)
                    .buildUpon()
                    .appendQueryParameter("title", title)
                    .appendQueryParameter("data", dataString)
                    .build()
                    .toString()
            }

            AndroidView(factory: { ctx in
                let webView = WebView(ctx)
                webView.layoutParams = ViewGroup.LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.MATCH_PARENT
                )
                webView.settings.javaScriptEnabled = true
                webView.settings.domStorageEnabled = true
                webView.settings.mediaPlaybackRequiresUserGesture = false
                webView.webViewClient = WebViewClient()
                webView.setBackgroundColor(android.graphics.Color.TRANSPARENT)

                if let url = chartURLString() {
                    webView.loadUrl(url)
                }
                return webView
            }, modifier: context.modifier, update: { webView in
                if let url = chartURLString() {
                    if webView.url != url {
                        webView.loadUrl(url)
                    }
                }
            })
        }
#elseif canImport(WebKit) && canImport(UIKit)
        AttendanceChartWKWebView(title: title, data: data)
#else
        Color.gray20
            .overlay(
                Text("WebView 미지원 환경")
                    .font(.finda(.body4))
                    .foregroundStyle(Color.gray70)
            )
#endif
    }
}

#if canImport(WebKit) && canImport(UIKit)
private struct AttendanceChartWKWebView: UIViewRepresentable {
    let title: String
    let data: [AttendanceChartPoint]

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let jsonData = try? JSONEncoder().encode(data),
              let dataString = String(data: jsonData, encoding: .utf8),
              !WebViewEndpoints.attendanceChartURL.isEmpty,
              var components = URLComponents(string: WebViewEndpoints.attendanceChartURL) else {
            return
        }

        components.queryItems = [
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "data", value: dataString)
        ]

        guard let url = components.url else { return }
        uiView.load(URLRequest(url: url))
    }
}
#endif
