import Foundation
import SwiftUI
#if SKIP
import android.webkit.WebView
import android.webkit.WebViewClient
import androidx.compose.ui.viewinterop.AndroidView
#endif

struct QRPage: Identifiable {
    let id: String
    let title: String
}

public struct QRCreateView: View {
    private let pages: [QRPage] = [
        QRPage(id: "1231231", title: "환경지킴이"),
        QRPage(id: "3543453", title: "바둑두기"),
        QRPage(id: "7867656", title: "화분에 물주기")
    ]
    @State private var currentIndex = 0

    public init() {}

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                pickerButton(title: "QR 생성", index: 0)
                pickerButton(title: "출석 그래프", index: 1)
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)

            if currentIndex == 0 {
                qrDisplayPager
            } else {
                chartWebContainer
            }
        }
        .background(Color.gray10.ignoresSafeArea())
    }

    @ViewBuilder
    private var qrDisplayPager: some View {
        VStack(spacing: 12) {
            TabView {
                ForEach(pages) { page in
                    VStack(spacing: 12) {
                        Text(page.title)
                            .font(.finda(.subheading2))
                            .foregroundStyle(Color.gray90)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        QRDisplayWebContainer(value: page.id)
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                }
            }
            #if !os(macOS)
            .tabViewStyle(.page(indexDisplayMode: .automatic))
            #endif
        }
    }

    private var chartWebContainer: some View {
        AttendanceChartWebContainer(
            title: "환경지킴이 출석률",
            data: [
                .init(month: "3월", value: 10),
                .init(month: "4월", value: 30),
                .init(month: "5월", value: 70),
                .init(month: "6월", value: 40),
                .init(month: "7월", value: 60)
            ]
        )
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding(24)
    }

    private func pickerButton(title: String, index: Int) -> some View {
        Button {
            currentIndex = index
        } label: {
            Text(title)
                .font(.finda(.body3))
                .foregroundStyle(currentIndex == index ? Color.gray10 : Color.gray70)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(currentIndex == index ? Color.blue50 : Color.gray20)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }
}

private struct AttendanceChartItem: Codable {
    let month: String
    let value: Int
}

#if SKIP
private struct QRDisplayWebContainer: View {
    let value: String

    var body: some View {
        ComposeView { context in
            AndroidView(factory: { ctx in
                let webView = WebView(ctx)
                configureAndroidWebView(webView)

                let uri = android.net.Uri.parse(WebViewEndpoints.baseURL)
                    .buildUpon()
                    .appendPath("qr-display")
                    .appendQueryParameter("value", value)
                    .build()
                    .toString()
                webView.loadUrl(uri)
                return webView
            }, modifier: context.modifier, update: { _ in
            })
        }
    }

    private func configureAndroidWebView(_ webView: WebView) {
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.settings.mediaPlaybackRequiresUserGesture = false
        webView.webViewClient = WebViewClient()
    }
}

private struct AttendanceChartWebContainer: View {
    let title: String
    let data: [AttendanceChartItem]

    var body: some View {
        ComposeView { context in
            AndroidView(factory: { ctx in
                let webView = WebView(ctx)
                configureAndroidWebView(webView)

                let payload = data
                    .map { "{\"month\":\"\($0.month)\",\"value\":\($0.value)}" }
                    .joined(separator: ",")
                let dataString = "[\(payload)]"

                let uri = android.net.Uri.parse(WebViewEndpoints.baseURL)
                    .buildUpon()
                    .appendPath("attendance-chart")
                    .appendQueryParameter("title", title)
                    .appendQueryParameter("data", dataString)
                    .build()
                    .toString()
                webView.loadUrl(uri)
                return webView
            }, modifier: context.modifier, update: { _ in
            })
        }
    }

    private func configureAndroidWebView(_ webView: WebView) {
        webView.settings.javaScriptEnabled = true
        webView.settings.domStorageEnabled = true
        webView.settings.mediaPlaybackRequiresUserGesture = false
        webView.webViewClient = WebViewClient()
    }
}
#elseif canImport(WebKit) && canImport(UIKit)
import UIKit
import WebKit

private struct QRDisplayWebContainer: UIViewRepresentable {
    let value: String

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard !WebViewEndpoints.qrDisplayURL.isEmpty,
              var components = URLComponents(string: WebViewEndpoints.qrDisplayURL) else { return }
        components.queryItems = [URLQueryItem(name: "value", value: value)]
        guard let url = components.url else { return }
        uiView.load(URLRequest(url: url))
    }
}

private struct AttendanceChartWebContainer: UIViewRepresentable {
    let title: String
    let data: [AttendanceChartItem]

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
              var components = URLComponents(string: WebViewEndpoints.attendanceChartURL) else { return }
        components.queryItems = [
            URLQueryItem(name: "title", value: title),
            URLQueryItem(name: "data", value: dataString)
        ]
        guard let url = components.url else { return }
        uiView.load(URLRequest(url: url))
    }
}
#else
private struct QRDisplayWebContainer: View {
    let value: String

    var body: some View {
        Color.gray20
            .overlay(
                Text("WebView 미지원 환경")
                    .font(.finda(.body4))
                    .foregroundStyle(Color.gray70)
            )
    }
}

private struct AttendanceChartWebContainer: View {
    let title: String
    let data: [AttendanceChartItem]

    var body: some View {
        Color.gray20
            .overlay(
                Text("WebView 미지원 환경")
                    .font(.finda(.body4))
                    .foregroundStyle(Color.gray70)
            )
    }
}
#endif
