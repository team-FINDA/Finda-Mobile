import SwiftUI

public extension Color {
    struct Blue {}
    struct Gray {}
    struct Sub {}
}

public extension Color.Blue {
    static let blue10: Color = DesignSystemAsset.Blue.blue10.swiftUIColor
    static let blue20: Color = DesignSystemAsset.Blue.blue20.swiftUIColor
    static let blue30: Color = DesignSystemAsset.Blue.blue30.swiftUIColor
    static let blue40: Color = DesignSystemAsset.Blue.blue40.swiftUIColor
    static let blue50: Color = DesignSystemAsset.Blue.blue50.swiftUIColor
    static let blue60: Color = DesignSystemAsset.Blue.blue60.swiftUIColor
}

public extension Color.Gray {
    static let gray10: Color = DesignSystemAsset.Gray.gray10.swiftUIColor
    static let gray20: Color = DesignSystemAsset.Gray.gray20.swiftUIColor
    static let gray30: Color = DesignSystemAsset.Gray.gray30.swiftUIColor
    static let gray40: Color = DesignSystemAsset.Gray.gray40.swiftUIColor
    static let gray50: Color = DesignSystemAsset.Gray.gray50.swiftUIColor
    static let gray60: Color = DesignSystemAsset.Gray.gray60.swiftUIColor
    static let gray70: Color = DesignSystemAsset.Gray.gray70.swiftUIColor
    static let gray80: Color = DesignSystemAsset.Gray.gray80.swiftUIColor
    static let gray90: Color = DesignSystemAsset.Gray.gray90.swiftUIColor
}

public extension Color.Sub {
    static let green10: Color = DesignSystemAsset.Sub.green10.swiftUIColor
    static let green20: Color = DesignSystemAsset.Sub.green20.swiftUIColor
    static let red10: Color = DesignSystemAsset.Sub.red10.swiftUIColor
    static let red20: Color = DesignSystemAsset.Sub.red20.swiftUIColor
}
