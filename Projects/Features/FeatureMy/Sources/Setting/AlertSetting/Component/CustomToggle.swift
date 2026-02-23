import SwiftUI
import DesignSystem

struct CustomToggle: View {
    var title: String
    var font: Font
    @Binding var isOn: Bool

    init(title: String, font: Font, isOn: Binding<Bool>) {
        self.title = title
        self.font = font
        self._isOn = isOn
    }

    var body: some View {
        HStack {
            Text(title)
                .font(font)
                .foregroundStyle(Color.Gray.gray90)

            Spacer()

            Toggle(title, isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: Color.Blue.blue30))
        }
    }
}

#Preview {
    CustomToggle(title: "공지사항", font: .finda(.subheading2), isOn: .constant(false))
}
