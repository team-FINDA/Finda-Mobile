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
                .frame(height: 120)
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
        for i in (0..<5).reversed() {
            if let date = calendar.date(byAdding: .month, value: -i, to: now) {
                monthlyData.append(MonthlyData(
                    month: formatter.string(from: date),
                    value: Double.random(in: 0.0...100.0)
                ))
            }
        }
        data = monthlyData
    }
}

struct SimpleLineChart: View {
    let data: [MonthlyData]
    let maxValue: Double = 100

    var body: some View {
        VStack(spacing: 0) {
            ChartCanvas(data: data, maxValue: maxValue)
                .frame(maxWidth: .infinity)
                .frame(height: 80)

            HStack(spacing: 0) {
                ForEach(data) { item in
                    Text(item.month)
                        .font(.finda(.caption4))
                        .foregroundColor(.gray90)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.top, 4)
        }
    }
}

struct ChartCanvas: View {
    let data: [MonthlyData]
    let maxValue: Double

    var body: some View {
        ZStack(alignment: .bottom) {
            // 그리드 라인
            VStack(spacing: 0) {
                ForEach([100, 75, 50, 25, 0], id: \.self) { _ in
                    Spacer()
                    Rectangle()
                        .fill(Color.gray40)
                        .frame(height: 0.5)
                }
            }

            // 라인 + 포인트
            ChartLineView(data: data, maxValue: maxValue)
        }
    }
}

struct ChartLineView: View {
    let data: [MonthlyData]
    let maxValue: Double

    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let count = data.count

            if count > 1 {
                ZStack {
                    ChartPath(data: data, width: width, height: height, maxValue: maxValue)
                        .stroke(Color.blue60, lineWidth: 2)

                    ForEach(0..<count, id: \.self) { i in
                        let x = width * CGFloat(i) / CGFloat(count - 1)
                        let y = height * (1 - CGFloat(data[i].value / maxValue))
                        Circle()
                            .strokeBorder(Color.blue60, lineWidth: 3)
                            .frame(width: 10, height: 10)
                            .position(x: x, y: y)
                    }
                }
            }
        }
    }
}

struct ChartPath: Shape {
    let data: [MonthlyData]
    let width: CGFloat
    let height: CGFloat
    let maxValue: Double

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let count = data.count
        guard count > 1 else { return path }

        let points = data.enumerated().map { i, item in
            CGPoint(
                x: width * CGFloat(i) / CGFloat(count - 1),
                y: height * (1 - CGFloat(item.value / maxValue))
            )
        }

        path.move(to: points[0])
        for point in points.dropFirst() {
            path.addLine(to: point)
        }
        return path
    }
}
