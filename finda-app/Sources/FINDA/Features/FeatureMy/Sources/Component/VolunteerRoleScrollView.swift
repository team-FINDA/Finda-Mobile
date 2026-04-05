#if !SKIP
import SwiftUI
import DesignSystem

struct VolunteerRoleScrollView: View {
    let roles: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Array(roles.enumerated()), id: \.offset) { _, interest in
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.Blue.blue40)
                            .frame(width: 4, height: 4)

                        Text(interest)
                            .font(.finda(.caption1))
                            .foregroundColor(.Gray.gray60)
                    }
                }
            }
        }
    }
}

#endif
