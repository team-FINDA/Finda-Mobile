import SwiftUI

struct CustomToggle: View {
    var title: String
    var font: Font
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(font)
                .foregroundStyle(Color.gray90)
            Spacer()
            Toggle(title, isOn: $isOn)
                .labelsHidden()
                .tint(Color.blue30)
        }
    }
}
