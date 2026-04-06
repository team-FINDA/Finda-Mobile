#if !SKIP && canImport(UIKit)
import SwiftUI

struct MonthlyEventResponse: Codable, Identifiable {
    let id: String
    let eventName: String
    let month: Int
    let day: Int
    let dayName: String
}

struct CalendarDay: Identifiable {
    let id = UUID()
    let date: Date?
    let events: [MonthlyEventResponse]

    var hasEvents: Bool { !events.isEmpty }
}

struct CalendarMonth {
    let year: Int
    let month: Int

    init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }

    init(date: Date) {
        let calendar = Calendar.current
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
    }

    var title: String { "\(year)년 \(month)월" }

    var firstDate: Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = 1
        return Calendar.current.date(from: components)!
    }

    func shifted(by value: Int) -> CalendarMonth {
        let movedDate = Calendar.current.date(byAdding: .month, value: value, to: firstDate)!
        return CalendarMonth(date: movedDate)
    }

    func days(eventMap: [Int: [MonthlyEventResponse]]) -> [CalendarDay] {
        let calendar = Calendar.current
        let firstWeekday = calendar.component(.weekday, from: firstDate) - 1
        let dayRange = calendar.range(of: .day, in: .month, for: firstDate)!

        var result: [CalendarDay] = []

        for _ in 0..<firstWeekday {
            result.append(CalendarDay(date: nil, events: []))
        }

        for day in dayRange {
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = day
            let date = calendar.date(from: components)!
            result.append(CalendarDay(date: date, events: eventMap[day] ?? []))
        }

        return result
    }
}

struct CalendarView: View {
    let monthlyEvents: [MonthlyEventResponse]
    let onSelectDay: (Int, Int) -> Void

    @State private var currentMonth: CalendarMonth
    @State private var selectedDate: Date?
    @State private var didSendInitialSelection = false

    private let weekdays = ["일", "월", "화", "수", "목", "금", "토"]

    init(
        monthlyEvents: [MonthlyEventResponse],
        onSelectDay: @escaping (Int, Int) -> Void
    ) {
        self.monthlyEvents = monthlyEvents
        self.onSelectDay = onSelectDay
        _currentMonth = State(initialValue: CalendarMonth(date: Date()))
        _selectedDate = State(initialValue: nil)
    }

    private var calendarDays: [CalendarDay] {
        currentMonth.days(eventMap: eventMap(for: currentMonth))
    }

    var body: some View {
        VStack(spacing: 20) {
            monthHeader
            weekdayHeader
            daysGrid
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.Gray.gray20)
        )
        .onAppear {
            guard !didSendInitialSelection else { return }
            didSendInitialSelection = true
            select(date: Date())
        }
    }

    private var monthHeader: some View {
        HStack(spacing: 12) {
            Button {
                currentMonth = currentMonth.shifted(by: -1)
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.Gray.gray90)
            }

            Text(currentMonth.title)
                .font(.finda(.body1))
                .foregroundColor(.Gray.gray90)

            Button {
                currentMonth = currentMonth.shifted(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.Gray.gray90)
            }
        }
    }

    private var weekdayHeader: some View {
        HStack(spacing: 0) {
            ForEach(weekdays, id: \.self) { day in
                Text(day)
                    .font(.finda(.body1))
                    .foregroundColor(.Gray.gray90)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private var daysGrid: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 7)
        return LazyVGrid(columns: columns, spacing: 4) {
            ForEach(calendarDays) { day in
                DayCellView(
                    calDay: day,
                    isSelected: isSelected(day),
                    isToday: isToday(day)
                ) {
                    guard let date = day.date else { return }
                    select(date: date)
                }
            }
        }
    }

    private func select(date: Date) {
        selectedDate = date
        let selectedMonth = Calendar.current.component(.month, from: date)
        let selectedDay = Calendar.current.component(.day, from: date)
        onSelectDay(selectedMonth, selectedDay)
    }

    private func eventMap(for month: CalendarMonth) -> [Int: [MonthlyEventResponse]] {
        Dictionary(grouping: monthlyEvents.filter { $0.month == month.month }, by: \.day)
    }

    private func isSelected(_ calDay: CalendarDay) -> Bool {
        guard
            let cellDate = calDay.date,
            let selectedDate
        else { return false }

        let calendar = Calendar.current
        let cellDay = calendar.component(.day, from: cellDate)
        let cellMonth = calendar.component(.month, from: cellDate)
        let cellYear = calendar.component(.year, from: cellDate)
        let selectedDay = calendar.component(.day, from: selectedDate)
        let selectedMonth = calendar.component(.month, from: selectedDate)
        let selectedYear = calendar.component(.year, from: selectedDate)

        return cellDay == selectedDay && cellMonth == selectedMonth && cellYear == selectedYear
    }

    private func isToday(_ calDay: CalendarDay) -> Bool {
        guard let cellDate = calDay.date else { return false }
        return Calendar.current.isDate(cellDate, inSameDayAs: Date())
    }
}

struct DayCellView: View {
    let calDay: CalendarDay
    let isSelected: Bool
    let isToday: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                if let date = calDay.date {
                    let dayNum = Calendar.current.component(.day, from: date)
                    Text("\(dayNum)")
                        .font(.finda(.body4))
                        .foregroundColor(.Gray.gray90)
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(isToday ? Color.Blue.blue20 : .clear))

                    Circle()
                        .fill(
                            (Color.Blue.blue30)
                                .opacity(calDay.hasEvents ? 1 : 0)
                        )
                        .frame(width: 4, height: 4)
                }
            }
            .frame(width: 36, height: 42)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill((isSelected && !isToday) ? Color.Blue.blue10 : .clear)
            )
        }
        .buttonStyle(.plain)
    }
}

struct CalendarView_Previews: PreviewProvider {
    private static let previewEvents: [MonthlyEventResponse] = [
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

    static var previews: some View {
        CalendarView(
            monthlyEvents: previewEvents,
            onSelectDay: { _, _ in }
        )
    }
}

#endif
