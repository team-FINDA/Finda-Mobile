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
                Image.Images.baseProfile
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text("Welcome,")
                        .font(.finda(.body4))
                        .foregroundStyle(Color.Gray.gray60)
                    Text(name)
                        .font(.finda(.body1))
                }

                Spacer()

                Button { notificationAction() } label: {
                    Image.Icons.bell
                }

            }
            .padding(.top, 20)

            HStack(spacing: 3.5) {
                Image.Icons.speakerphone

                Text("FINDA에 새로운 기능이 추가되었어요!")
                    .font(.finda(.body4))
                    .foregroundStyle(Color.Gray.gray80)

                Spacer()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 9)
            .background(Color.Blue.blue10.cornerRadius(20))
            .onTapGesture { shortNotificationAction() }
        }
    }
}

#Preview {
    MainHeaderView(name: "2216 하원", notificationAction: {}, shortNotificationAction: {})
}
