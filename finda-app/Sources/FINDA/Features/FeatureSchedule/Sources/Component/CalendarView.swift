import SwiftUI

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
                .fill(Color.gray20)
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
                    .foregroundColor(.gray90)
            }

            Text(currentMonth.title)
                .font(.finda(.body1))
                .foregroundColor(.gray90)

            Button {
                currentMonth = currentMonth.shifted(by: 1)
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray90)
            }
        }
    }

    private var weekdayHeader: some View {
        HStack(spacing: 0) {
            ForEach(weekdays, id: \.self) { day in
                Text(day)
                    .font(.finda(.body1))
                    .foregroundColor(.gray90)
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
        var grouped: [Int: [MonthlyEventResponse]] = [:]

        for event in monthlyEvents where event.month == month.month {
            grouped[event.day, default: []].append(event)
        }

        return grouped
    }

    private func isSelected(_ calDay: CalendarDay) -> Bool {
        guard let cellDate = calDay.date, let selectedDate else { return false }
        let calendar = Calendar.current
        return calendar.component(.day, from: cellDate) == calendar.component(.day, from: selectedDate)
            && calendar.component(.month, from: cellDate) == calendar.component(.month, from: selectedDate)
            && calendar.component(.year, from: cellDate) == calendar.component(.year, from: selectedDate)
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
                        .foregroundColor(.gray90)
                        .frame(width: 28, height: 28)
                        .background(Circle().fill(isToday ? Color.blue20 : Color.clear))

                    Circle()
                        .fill(Color.blue30.opacity(calDay.hasEvents ? 1.0 : 0.0))
                        .frame(width: 4, height: 4)
                }
            }
            .frame(width: 36, height: 42)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill((isSelected && !isToday) ? Color.blue10 : Color.clear)
            )
        }
        .buttonStyle(.plain)
    }
}
