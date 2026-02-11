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

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    TeacherMainView()
}
