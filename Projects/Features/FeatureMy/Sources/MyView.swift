import SwiftUI
import DesignSystem
import Shared

public struct MyView: View {
    private let role: UserRole
    private let studentName = "2216 하원"
    private let roles = ["환경지킴이", "교감쌤과 바둑두기", "화단에 물주기"]
    @State private var selectedFilter: VolunteerStatus = .all

    public init(role: UserRole) {
        self.role = role
    }

    private var filteredActivities: [VolunteerListResponse] {
        if selectedFilter == .all {
            return dummyActivities
        }
        return dummyActivities.filter { $0.status == selectedFilter }
    }

    public var body: some View {
        VStack(spacing: 16) {
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

            Button(action: {}, label: {
                Text(role == .student ? "봉사 활동 내역 확인" : "공지사항 관리/생성")
                    .font(.finda(.body1))
                    .foregroundColor(.Blue.blue50)

                Spacer()

                Image.Icons.rightArrow
                    .renderingMode(.template)
                    .foregroundColor(.Blue.blue50)
            })
            .padding(18)
            .background(Color.Blue.blue10)
            .cornerRadius(16)

            VolunteerFilterView(selectedFilter: $selectedFilter)
            VolunteerListView(activities: filteredActivities)

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
}

#Preview {
    MyView(role: .student)
}
