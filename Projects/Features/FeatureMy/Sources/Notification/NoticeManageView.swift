import SwiftUI
import DesignSystem

struct NoticeManageView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { dismiss() }, label: {
                    Image.Icons.leftArrow
                        .foregroundStyle(Color.Gray.gray80)
                })

                Spacer()

                Text("공지사항 관리")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)

                Spacer()

                Button(action: {}, label: {
                    Image.Icons.add
                })
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
    NoticeManageView()
}
