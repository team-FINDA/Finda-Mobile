#if !SKIP
import SwiftUI
import DesignSystem

struct SettingPopup: View {
    var title: String
    var content: String
    var cancelAction: () -> Void
    var okAction: () -> Void

    init(
        title: String,
        content: String,
        cancelAction: @escaping () -> Void = {},
        okAction: @escaping () -> Void = {}
    ) {
        self.title = title
        self.content = content
        self.cancelAction = cancelAction
        self.okAction = okAction
    }

    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.finda(.subheading2))
                .foregroundStyle(Color.Sub.red20)

            Text(content)
                .font(.finda(.body4))
                .foregroundStyle(Color.Gray.gray60)
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Button(action: { cancelAction() }, label: {
                    Text("취소")
                        .font(.finda(.body3))
                        .foregroundStyle(Color.Gray.gray60)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                })
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color.Gray.gray30)
                )

                Button(action: { okAction() }, label: {
                    Text(title)
                        .font(.finda(.body3))
                        .foregroundStyle(Color.Sub.red20)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                })
                .background(
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .fill(Color.Sub.red10)
                )
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.Gray.gray10)
        )
    }
}

#Preview {
    VStack {
        SettingPopup(
            title: "로그아웃",
            content: "정말 로그아웃 하시겠습니까?\n로그아웃 시 다시 로그인해야 합니다.",
            cancelAction: {},
            okAction: {}
        )
    }.padding(.horizontal, 52)
}

#endif
