import Foundation

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
