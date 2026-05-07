import SwiftUI

@inline(__always)
func FINDAImage(_ name: String) -> Image {
    return Image(name, bundle: .module)
}
