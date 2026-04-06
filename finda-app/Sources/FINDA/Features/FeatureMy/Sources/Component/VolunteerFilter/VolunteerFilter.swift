import SwiftUI

struct VolunteerFilterView: View {
    @Binding var selectedFilter: VolunteerStatus

    var body: some View {
        HStack(spacing: 8) {
            ForEach(VolunteerStatus.allCases, id: \.self) { filter in
                FilterCell(
                    title: filter.rawValue,
                    isSelected: selectedFilter == filter,
                    onTap: { selectedFilter = filter }
                )
            }
            Spacer()
        }
    }
}

private struct FilterCell: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.finda(.body3))
                .foregroundColor(isSelected ? .blue40 : .gray50)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(isSelected ? Color.blue40 : Color.gray50)
                )
        }
    }
}
