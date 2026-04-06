import SwiftUI

public struct MainHeaderView: View {
    private let name: String
    private let notificationAction: () -> Void
    private let shortNotificationAction: () -> Void

    public init(
        name: String,
        notificationAction: @escaping () -> Void,
        shortNotificationAction: @escaping () -> Void
    ) {
        self.name = name
        self.notificationAction = notificationAction
        self.shortNotificationAction = shortNotificationAction
    }

    public var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 16) {
                FINDAImage("baseProfile")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome,")
                        .font(.finda(.body4))
                        .foregroundStyle(Color.gray60)
                    Text(name)
                        .font(.finda(.body1))
                }

                Spacer()

                Button { notificationAction() } label: {
                    FINDAImage("bell")
                }

            }
            .padding(.top, 20)

            HStack(spacing: 3.5) {
                FINDAImage("speakerphone")

                Text("FINDA에 새로운 기능이 추가되었어요!")
                    .font(.finda(.body4))
                    .foregroundStyle(Color.gray80)

                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.blue10)
            )
            .onTapGesture { shortNotificationAction() }
        }
    }
}

#Preview {
    MainHeaderView(name: "2216 하원", notificationAction: {}, shortNotificationAction: {})
}
