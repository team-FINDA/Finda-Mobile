import SwiftUI
import Charts

struct MonthlyData: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
}

struct GraphView: View {
    @State private var data: [MonthlyData] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("봉사활동 출석률")
                .font(.finda(.body1))
                .foregroundStyle(Color.Gray.gray90)
                .padding(.top, 15)
                .padding(.leading, 15)

            Chart(data) { item in
                AreaMark(
                    x: .value("월", item.month),
                    y: .value("값", item.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.Blue.blue60.opacity(0.2)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                LineMark(
                    x: .value("월", item.month),
                    y: .value("값", item.value)
                )
                .foregroundStyle(Color.Blue.blue60)
                .lineStyle(StrokeStyle(lineWidth: 2))

                PointMark(
                    x: .value("월", item.month),
                    y: .value("값", item.value)
                )
                .foregroundStyle(Color.Gray.gray10)
                .symbolSize(100)

                PointMark(
                    x: .value("월", item.month),
                    y: .value("값", item.value)
                )
                .foregroundStyle(Color.Blue.blue60)
                .symbolSize(100)
                .symbol {
                    Circle()
                        .strokeBorder(Color.Blue.blue60, lineWidth: 3)
                        .frame(width: 10, height: 10)
                }
            }
            .chartYScale(domain: 0...100)
            .chartXScale(range: .plotDimension(startPadding: 0, endPadding: 0))
            .chartYAxis {
                AxisMarks(position: .leading, values: [0, 25, 50, 75, 100]) { _ in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                        .foregroundStyle(Color.Gray.gray40)
                    AxisValueLabel()
                        .foregroundStyle(Color.Gray.gray90)
                }
            }
            .chartXAxis {
                AxisMarks(values: .automatic) { _ in
                    AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                        .foregroundStyle(Color.Gray.gray40)
                    AxisValueLabel()
                        .foregroundStyle(Color.Gray.gray90)
                }
            }
            .frame(height: 100)
            .padding()
            .onAppear {
                loadData()
            }
        }
        .background(Color.Gray.gray20)
        .cornerRadius(10)
    }

    func loadData() {
        let calendar = Calendar.current
        let now = Date()
        var monthlyData: [MonthlyData] = []

        for value in (0..<5).reversed() {
            if let date = calendar.date(byAdding: .month, value: -value, to: now) {
                let monthFormatter = DateFormatter()
                monthFormatter.dateFormat = "M월"
                let monthString = monthFormatter.string(from: date)

                let randomValue = Double.random(in: 0...100)

                monthlyData.append(MonthlyData(month: monthString, value: randomValue))
            }
        }

        data = monthlyData
    }
}

#Preview {
    GraphView()
}
