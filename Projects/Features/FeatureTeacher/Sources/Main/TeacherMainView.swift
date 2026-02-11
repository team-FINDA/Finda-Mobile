import SwiftUI
import DesignSystem

public struct TeacherMainView: View {
    public init() {}

    public var body: some View {
        VStack(spacing: 20) {
            MainHeaderView(
                name: "하원 선생님",
                notificationAction: {},
                shortNotificationAction: {}
            )

            HStack(spacing: 12) {
                Button(action: {}, label: {
                    HStack(spacing: 8) {
                        Text("환경지킴이")
                            .font(.finda(.body1))
                            .foregroundColor(.Gray.gray90)
                        
                        Image.Icons.change
                    }
                    .padding(12)
                    .background(Color.Gray.gray20)
                    .cornerRadius(4)
                })

                Text("학생")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)

                Spacer()
            }

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    TeacherMainView()
}
