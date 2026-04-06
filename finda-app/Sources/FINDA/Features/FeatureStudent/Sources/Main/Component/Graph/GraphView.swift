import SwiftUI

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
                .foregroundStyle(Color.gray90)
                .padding(.top, 15)
                .padding(.leading, 15)

            SimpleLineChart(data: data)
                .frame(height: 100)
                .padding()
        }
        .background(Color.gray20)
        .cornerRadius(10)
        .onAppear { loadData() }
    }

    func loadData() {
        let calendar = Calendar.current
        let now = Date()
        var monthlyData: [MonthlyData] = []
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"

        for value in (0..<5).reversed() {
            if let date = calendar.date(byAdding: .month, value: -value, to: now) {
                monthlyData.append(MonthlyData(
                    month: formatter.string(from: date),
                    value: Double.random(in: 0...100)
                ))
            }
        }
        data = monthlyData
    }
}

struct SimpleLineChart: View {
    let data: [MonthlyData]

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let maxValue = 100.0
            let count = data.count

            guard count > 1 else {
                return AnyView(EmptyView())
            }

            let points: [CGPoint] = data.enumerated().map { i, item in
                CGPoint(
                    x: width * CGFloat(i) / CGFloat(count - 1),
                    y: height * (1 - CGFloat(item.value / maxValue))
                )
            }

            return AnyView(
                ZStack {
                    // 배경 그리드
                    VStack(spacing: 0) {
                        ForEach([0, 25, 50, 75, 100], id: \.self) { _ in
                            Spacer()
                            Rectangle()
                                .fill(Color.gray40)
                                .frame(height: 0.5)
                        }
                    }

                    // 라인
                    Path { path in
                        path.move(to: points[0])
                        for point in points.dropFirst() {
                            path.addLine(to: point)
                        }
                    }
                    .stroke(Color.blue60, lineWidth: 2)

                    // 포인트
                    ForEach(0..<points.count, id: \.self) { i in
                        Circle()
                            .strokeBorder(Color.blue60, lineWidth: 3)
                            .frame(width: 10, height: 10)
                            .position(points[i])
                    }

                    // X축 레이블
                    HStack(spacing: 0) {
                        ForEach(data) { item in
                            Text(item.month)
                                .font(.finda(.caption4))
                                .foregroundColor(.gray90)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .offset(y: 16)
                }
            )
        }
    }
}
