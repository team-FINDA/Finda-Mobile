import SwiftUI
import DesignSystem

public struct ScheduleView: View {
    private static let exampleEvents: [MonthlyEventResponse] = [
        MonthlyEventResponse(
            id: UUID().uuidString,
            eventName: "모의고사",
            month: 2,
            day: 3,
            dayName: "화"
        ),
        MonthlyEventResponse(
            id: UUID().uuidString,
            eventName: "동아리 발표",
            month: 2,
            day: 12,
            dayName: "목"
        ),
        MonthlyEventResponse(
            id: UUID().uuidString,
            eventName: "봉사 활동",
            month: 2,
            day: 21,
            dayName: "토"
        )
    ]
    public init() {}

    public var body: some View {
        HStack {
            Text("봉사활동 일정")
                .font(.finda(.body1))
                .foregroundColor(.Gray.gray90)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)

        VStack {
            CalendarView(
                monthlyEvents: ScheduleView.exampleEvents,
                onSelectDay: {_, _ in}
            )
            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
    }
}

#Preview {
    ScheduleView()
}
