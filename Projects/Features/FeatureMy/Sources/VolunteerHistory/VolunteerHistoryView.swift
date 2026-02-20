import SwiftUI
import DesignSystem

struct VolunteerHistoryView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }, label: {
                    Image.Icons.leftArrow
                        .foregroundStyle(Color.Gray.gray80)
                })

                Spacer()

                Text("봉사활동 내역")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)

                Spacer()

                Image.Icons.leftArrow
                    .opacity(0)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    VolunteerHistoryView()
}
