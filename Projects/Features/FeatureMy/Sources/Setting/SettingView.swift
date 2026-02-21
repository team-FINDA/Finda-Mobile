import SwiftUI
import DesignSystem

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { dismiss() }, label: {
                    Image.Icons.leftArrow
                        .foregroundStyle(Color.Gray.gray80)
                })

                Spacer()

                Text("설정")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)

                Spacer()

                Image.Icons.leftArrow
                    .opacity(0)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            VStack(spacing: 40) {
                Image.Images.baseProfile
                    .clipShape(.circle)

                SettingButton(
                    buttonText: "알림 설정",
                    textColor: Color.Gray.gray90,
                    action: {}
                )
                SettingButton(
                    buttonText: "비밀번호 설정",
                    textColor: Color.Blue.blue50,
                    action: {}
                )

                VStack(spacing: 16) {
                    SettingButton(
                        buttonText: "로그아웃",
                        action: {}
                    )
                    SettingButton(
                        buttonText: "회원탈퇴",
                        action: {}
                    )
                }

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    SettingView()
}
