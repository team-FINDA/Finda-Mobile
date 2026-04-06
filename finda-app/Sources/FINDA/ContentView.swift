import SwiftUI

#if !SKIP && canImport(UIKit)
struct ContentView: View {
    var body: some View {
        AppContentView()
    }
}
#else
struct ContentView: View {
    var body: some View {
        Text("FINDA")
    }
}
#endif
