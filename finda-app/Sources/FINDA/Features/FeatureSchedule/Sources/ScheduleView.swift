import SwiftUI

public struct ScheduleView: View {
    private static let exampleEvents: [MonthlyEventResponse] = [
        MonthlyEventResponse(id: UUID().uuidString, eventName: "모의고사", month: 2, day: 3, dayName: "화"),
        MonthlyEventResponse(id: UUID().uuidString, eventName: "동아리 발표", month: 2, day: 12, dayName: "목"),
        MonthlyEventResponse(id: UUID().uuidString, eventName: "봉사 활동", month: 2, day: 19, dayName: "목"),
        MonthlyEventResponse(id: UUID().uuidString, eventName: "봉사 활동2", month: 2, day: 19, dayName: "목")
    ]

    @State private var selectMonth: Int = 0
    @State private var selectDay: Int = 0

    public init() {}

    private var selectedEvents: [MonthlyEventResponse] {
        ScheduleView.exampleEvents.filter {
            $0.month == selectMonth && $0.day == selectDay
        }
    }

    public var body: some View {
        VStack {
            HStack {
                Text("봉사활동 일정")
                    .font(.finda(.body1))
                    .foregroundColor(.gray90)
            }
            .padding(.vertical, 12)

            VStack(spacing: 16) {
                CalendarView(
                    monthlyEvents: ScheduleView.exampleEvents,
                    onSelectDay: { month, day in
                        selectMonth = month
                        selectDay = day
                    }
                )

                VStack(alignment: .leading, spacing: 16) {
                    Text("\(selectMonth)월 \(selectDay)일")
                        .font(.finda(.caption2))
                        .foregroundColor(.gray80)

                    if selectedEvents.isEmpty {
                        HStack {
                            Text("일정이 없습니다")
                                .font(.finda(.caption1))
                                .foregroundColor(.gray80)
                            Spacer()
                        }
                        .padding(.bottom, 8)
                    } else {
                        LazyVStack(spacing: 0) {
                            ForEach(selectedEvents) { event in
                                HStack(spacing: 12) {
                                    Circle()
                                        .fill(Color.blue30)
                                        .frame(width: 5, height: 5)
                                    Text(event.eventName)
                                        .font(.finda(.caption1))
                                        .foregroundColor(.gray90)
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .padding(15)
                .background(Color.gray20)
                .cornerRadius(10)

                Spacer()
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 20)
        }
    }
}
