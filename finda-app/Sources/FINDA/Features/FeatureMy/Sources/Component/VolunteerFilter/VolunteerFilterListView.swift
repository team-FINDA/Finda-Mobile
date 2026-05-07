import SwiftUI

struct VolunteerFilterListView: View {
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
        HStack(alignment: .center) { // Return type mismatch: expected 'ComposeResult', actual 'View'.
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.finda(.body3))
                    .foregroundColor(.gray90)
                Text("\(item.startDate) ~ \(item.endDate)")
                    .font(.finda(.caption4))
                    .foregroundColor(.gray80)
            }
            Spacer()
            VolunteerStatusTag(status: item.status)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(Color.gray10)
        .cornerRadius(5)
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .strokeBorder(Color.gray40, lineWidth: 0.8)
        }
    }
}

struct VolunteerStatusTag: View {
    let status: VolunteerStatus

    var borderColor: Color {
        switch status {
        case .waiting: return .blue50
        case .inProgress: return .green20
        case .ended: return .red20
        case .all: return .gray50
        }
    }

    var textColor: Color {
        switch status {
        case .waiting: return .blue40
        case .inProgress: return .green20
        case .ended: return .red20
        case .all: return .gray50
        }
    }

    var backgroundColor: Color {
        switch status {
        case .waiting: return .blue10
        case .inProgress: return .green10
        case .ended: return .red10
        case .all: return .gray10
        }
    }

    var body: some View {
        Text(status.rawValue) // Return type mismatch: expected 'ComposeResult', actual 'View'.
            .font(.finda(.caption1))
            .foregroundColor(textColor)
            .padding(.horizontal, 7)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .cornerRadius(15)
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .strokeBorder(borderColor, lineWidth: 0.5)
            }
    }
}
