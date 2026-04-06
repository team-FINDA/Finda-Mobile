import SwiftUI

struct MyView: View {
    var viewModel: MyRootViewModel

    private let studentName = "2216 하원"
    private let roles = ["환경지킴이", "교감쌤과 바둑두기", "화단에 물주기"]
    @State private var selectedFilter: VolunteerStatus = .all

    private var filteredActivities: [VolunteerListResponse] {
        if selectedFilter == .all { return dummyActivities }
        return dummyActivities.filter { $0.status == selectedFilter }
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                FINDAImage("baseProfile")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(studentName)
                        .font(.finda(.body1))
                        .foregroundColor(.gray90)

                    if viewModel.role == .student {
                        VolunteerRoleScrollView(roles: roles)
                    }
                }
                Spacer()

                Button(action: { viewModel.settingTapped() }) {
                    FINDAImage("setting")
                }
            }

            Button(action: { viewModel.myButtonTapped() }) {
                Text(viewModel.role == .student ? "봉사 활동 내역 확인" : "공지사항 관리/생성")
                    .font(.finda(.body1))
                    .foregroundColor(.blue50)
                Spacer()
                FINDAImage("rightArrow")
                    .renderingMode(.template)
                    .foregroundColor(.blue50)
            }
            .padding(18)
            .background(Color.blue10)
            .cornerRadius(16)

            VolunteerFilterView(selectedFilter: $selectedFilter)
            VolunteerFilterListView(activities: filteredActivities)

            Spacer()
        }
        .toolbar(.hidden, for: .navigationBar)
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
}
