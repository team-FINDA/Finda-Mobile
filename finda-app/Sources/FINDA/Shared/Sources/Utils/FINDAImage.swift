import SwiftUI

@inline(__always)
func FINDAImage(_ name: String) -> Image {
#if SKIP
    return Image(name)
#else
    return Image(name, bundle: .module)
#endif
}
