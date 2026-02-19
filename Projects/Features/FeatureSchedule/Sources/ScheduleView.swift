import SwiftUI
import DesignSystem

public struct ScheduleView: View {
    public init() {}

    public var body: some View {
        VStack {
            HStack {
                Text("봉사활동 일정")
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            Spacer()
        }
    }
}

#Preview {
    ScheduleView()
}
