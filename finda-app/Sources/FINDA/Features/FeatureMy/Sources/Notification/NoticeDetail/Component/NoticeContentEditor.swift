#if !SKIP
import SwiftUI
import DesignSystem

struct NoticeContentEditor: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("내용")
                .font(.finda(.body1))
                .foregroundColor(Color.Gray.gray80)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .focused($isFocused)
                    .font(.finda(.body2))
                    .foregroundColor(Color.Gray.gray90)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 9)
                    .frame(minHeight: 150)
                    .frame(maxHeight: 180)

                if text.isEmpty {
                    Text("내용을 입력해주세요")
                        .font(.finda(.body2))
                        .foregroundColor(Color.Gray.gray50)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 17)
                        .allowsHitTesting(false)
                }
            }
            .background(Color.Gray.gray20)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isFocused ? Color.Blue.blue50 : Color.Gray.gray20, lineWidth: 1)
            )
        }
    }
}

#Preview {
    NoticeContentEditor(text: .constant(""))
}

#endif
