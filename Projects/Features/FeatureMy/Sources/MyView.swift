import SwiftUI
import DesignSystem
import Shared

public struct MyView: View {
    private let role: UserRole
    private let studentName = "2216 하원"
    private let roles = ["환경지킴이", "교감쌤과 바둑두기", "화단에 물주기"]

    public init(role: UserRole) {
        self.role = role
    }

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image.Images.baseProfile
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(studentName)
                        .font(.finda(.body1))
                        .foregroundColor(.Gray.gray90)

                    if role == .student {
                        VolunteerRoleScrollView(roles: roles)
                    }
                }
                Spacer()

                Button(action: {}, label: {
                    Image.Icons.setting
                })
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
}

#Preview {
    MyView(role: .student)
}
