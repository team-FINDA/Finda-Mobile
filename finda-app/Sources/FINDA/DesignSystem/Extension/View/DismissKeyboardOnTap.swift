import SwiftUI

struct DismissKeyboardOnTap: ViewModifier {
    func body(content: Content) -> some View {
        #if SKIP
        content
        #else
        #if canImport(UIKit)
        content
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.sendAction(
                    #selector(UIResponder.resignFirstResponder),
                    to: nil,
                    from: nil,
                    for: nil
                )
            }
        #else
        content
        #endif
        #endif
    }
}

extension View {
    public func dismissKeyboardOnTap() -> some View {
        modifier(DismissKeyboardOnTap())
    }
}
