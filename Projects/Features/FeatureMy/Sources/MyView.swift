import SwiftUI
import ComposableArchitecture
import DesignSystem

public struct MyView: View {
    @Perception.Bindable private var store: StoreOf<MyFeature>

    private let studentName = "2216 하원"
    private let roles = ["환경지킴이", "교감쌤과 바둑두기", "화단에 물주기"]
    @State private var selectedFilter: VolunteerStatus = .all

    public init(store: StoreOf<MyFeature>) {
        self.store = store
    }

    private var filteredActivities: [VolunteerListResponse] {
        if selectedFilter == .all {
            return dummyActivities
        }
        return dummyActivities.filter { $0.status == selectedFilter }
    }

    public var body: some View {
        WithPerceptionTracking {
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

                        if store.role == .student {
                            VolunteerRoleScrollView(roles: roles)
                        }
                    }
                    Spacer()

                    Button(action: { store.send(.settingButtonTapped) }, label: {
                        Image.Icons.setting
                    })
                }

                Button(action: { store.send(.myButtonTapped) }, label: {
                    Text(store.role == .student ? "봉사 활동 내역 확인" : "공지사항 관리/생성")
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
            .toolbar(.hidden, for: .navigationBar)
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color.Gray.gray10.ignoresSafeArea())
        }
    }
}

#Preview {
    MyView(
        store: Store(initialState: MyFeature.State(role: .student)) {
            MyFeature()
        }
    )
}
