import SwiftUI
import DesignSystem

struct VolunteerListResponse: Identifiable {
    let id: String
    let title: String
    let startDate: String
    let endDate: String
    let status: VolunteerStatus
}

enum VolunteerStatus: String, CaseIterable {
    case all = "전체"
    case waiting = "대기중"
    case inProgress = "진행중"
    case ended = "종료"
}

let dummyActivities: [VolunteerListResponse] = [
    VolunteerListResponse(id: "1", title: "환경 지킴이 활동", startDate: "2025/04/16", endDate: "2025/07/30", status: .waiting),
    VolunteerListResponse(id: "2", title: "환경 지킴이 활동", startDate: "2025/04/16", endDate: "2025/07/30", status: .waiting),
    VolunteerListResponse(id: "3", title: "환경 지킴이 활동", startDate: "2025/04/16", endDate: "2025/07/30", status: .inProgress),
    VolunteerListResponse(id: "4", title: "환경 지킴이 활동", startDate: "2025/04/16", endDate: "2025/07/30", status: .ended),
    VolunteerListResponse(id: "5", title: "환경 지킴이 활동", startDate: "2025/04/16", endDate: "2025/07/30", status: .inProgress),
    VolunteerListResponse(id: "6", title: "환경 지킴이 활동", startDate: "2025/04/16", endDate: "2025/07/30", status: .waiting)
]

struct VolunteerListView: View {
    let activities: [VolunteerListResponse]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(activities) { item in
                    VolunteerCell(item: item)
                }
            }
            .padding(.bottom, 24)
        }
    }
}

private struct VolunteerCell: View {
    let item: VolunteerListResponse

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.finda(.body3))
                    .foregroundColor(.Gray.gray90)

                Text("\(item.startDate) ~ \(item.endDate)")
                    .font(.finda(.caption4))
                    .foregroundColor(.Gray.gray80)
            }

            Spacer()

            StatusTag(status: item.status)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.Gray.gray40, lineWidth: 0.8)
        )
    }
}

private struct StatusTag: View {
    let status: VolunteerStatus

    private var borderColor: Color {
        switch status {
        case .waiting: return .Blue.blue50
        case .inProgress: return .Sub.green20
        case .ended: return .Sub.red20
        case .all: return .Gray.gray50
        }
    }

    private var textColor: Color {
        switch status {
        case .waiting: return .Blue.blue40
        case .inProgress: return .Sub.green20
        case .ended: return .Sub.red20
        case .all: return .Gray.gray50
        }
    }

    private var backgroundColor: Color {
        switch status {
        case .waiting: return .Blue.blue10
        case .inProgress: return .Sub.green10
        case .ended: return .Sub.red10
        case .all: return .Gray.gray10
        }
    }

    var body: some View {
        Text(status.rawValue)
            .font(.finda(.caption1))
            .foregroundColor(textColor)
            .padding(.horizontal, 7)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(borderColor, lineWidth: 0.5)
            )
    }
}

#Preview {
    VolunteerListView(activities: dummyActivities)
}
