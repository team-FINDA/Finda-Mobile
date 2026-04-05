import SwiftUI

public extension Color {
    static let blue10 = Color(hex: "#ECF0FFFF")
    static let blue20 = Color(hex: "#BFCCFFFF")
    static let blue30 = Color(hex: "#88A0FCFF")
    static let blue40 = Color(hex: "#6686FFFF")
    static let blue50 = Color(hex: "#2E56F5FF")
    static let blue60 = Color(hex: "#2A4EDBFF")

    static let gray10 = Color(hex: "#FFFFFFFF")
    static let gray20 = Color(hex: "#F7F7F7FF")
    static let gray30 = Color(hex: "#E9E9E9FF")
    static let gray40 = Color(hex: "#D1D1D1FF")
    static let gray50 = Color(hex: "#ABABABFF")
    static let gray60 = Color(hex: "#7A7A7AFF")
    static let gray70 = Color(hex: "#5C5C5CFF")
    static let gray80 = Color(hex: "#434343FF")
    static let gray90 = Color(hex: "#000000FF")

    static let green10 = Color(hex: "#DAFFE1FF")
    static let green20 = Color(hex: "#5FC273FF")
    static let red10 = Color(hex: "#FFDDDDFF")
    static let red20 = Color(hex: "#FF0000FF")
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
