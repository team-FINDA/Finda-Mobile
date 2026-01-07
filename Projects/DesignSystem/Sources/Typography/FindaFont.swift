import UIKit

public extension UIFont {
    static func findaFont(_ font: FindaFontStyle) -> UIFont {
        font.uiFont()
    }
}

extension FindaFontStyle {
    func uiFont() -> UIFont {
        let pretendard = DesignSystemFontFamily.Pretendard.self

        switch self {

        case .heading1:
            return pretendard.bold.font(size: 40)
        case .heading2:
            return pretendard.bold.font(size: 36)
        case .heading3:
            return pretendard.bold.font(size: 32)
        case .heading4:
            return pretendard.bold.font(size: 28)
        case .heading5:
            return pretendard.bold.font(size: 24)

        case .subheading1:
            return pretendard.semiBold.font(size: 32)
        case .subheading2:
            return pretendard.semiBold.font(size: 20)

        case .body1:
            return pretendard.semiBold.font(size: 16)
        case .body2:
            return pretendard.regular.font(size: 16)
        case .body3:
            return pretendard.semiBold.font(size: 14)
        case .body4:
            return pretendard.regular.font(size: 14)

        case .caption1:
            return pretendard.semiBold.font(size: 12)
        case .caption2:
            return pretendard.regular.font(size: 12)
        case .caption3:
            return pretendard.semiBold.font(size: 10)
        case .caption4:
            return pretendard.regular.font(size: 10)

        case .button:
            return pretendard.semiBold.font(size: 18)

        }
    }
}
