import SwiftUI
import DesignSystem

struct VolunteerListView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image.Icons.leftArrow
                        .foregroundStyle(Color.Gray.gray80)
                }

                Spacer()

                Text("봉사활동 게시물")
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
    }
}

#Preview {
    VolunteerListView()
}
