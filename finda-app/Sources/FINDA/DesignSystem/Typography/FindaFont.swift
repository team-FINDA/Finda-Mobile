import SwiftUI

public extension Font {
    static func finda(_ style: FindaFontStyle) -> Font {
        switch style {
        case .heading1:
            return .system(size: 40, weight: .bold)
        case .heading2:
            return .system(size: 36, weight: .bold)
        case .heading3:
            return .system(size: 32, weight: .bold)
        case .heading4:
            return .system(size: 28, weight: .bold)
        case .heading5:
            return .system(size: 24, weight: .bold)

        case .subheading1:
            return .system(size: 32, weight: .semibold)
        case .subheading2:
            return .system(size: 20, weight: .semibold)

        case .body1:
            return .system(size: 16, weight: .semibold)
        case .body2:
            return .system(size: 16, weight: .regular)
        case .body3:
            return .system(size: 14, weight: .semibold)
        case .body4:
            return .system(size: 14, weight: .regular)

        case .caption1:
            return .system(size: 12, weight: .semibold)
        case .caption2:
            return .system(size: 12, weight: .regular)
        case .caption3:
            return .system(size: 10, weight: .semibold)
        case .caption4:
            return .system(size: 10, weight: .regular)

        case .button:
            return .system(size: 18, weight: .semibold)
        }
    }
}
