import SwiftUI
import DesignSystem

struct VolunteerPostView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        HStack {
            Button(action: { dismiss() }, label: {
                Image.Icons.leftArrow
                    .foregroundStyle(Color.Gray.gray80)
            })

            Spacer()

            Text("봉사활동 제목??")
                .font(.finda(.body1))
                .foregroundColor(.Gray.gray90)

            Spacer()

            Image.Icons.leftArrow
                .opacity(0)
                .accessibilityHidden(true)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 8)

        VStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text("봉사활동 제목")
                    .font(.finda(.heading5))
                    .foregroundColor(.Gray.gray90)
                Text("봉사활동 내용입니다.")
                    .font(.finda(.body4))
                    .foregroundColor(.Gray.gray90)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)

            VStack(spacing: 15) {
                HStack(spacing: 13) {
                    InfoView(
                        icon: Image.Icons.calendar,
                        title: "신청 기간",
                        content: "2025.3.10 ~\n2025.3.12",
                        date: true
                    )
                    .frame(maxWidth: .infinity)
                    InfoView(
                        icon: Image.Icons.calendar,
                        title: "활동 기간",
                        content: "2025.3.10 ~\n2025.3.12",
                        date: true
                    )
                    .frame(maxWidth: .infinity)
                }
                HStack(spacing: 13) {
                    InfoView(
                        icon: Image.Icons.time,
                        title: "봉사 기간",
                        content: "8시간"
                    )
                    .frame(maxWidth: .infinity)
                    InfoView(
                        icon: Image.Icons.people,
                        title: "활동 기간",
                        content: "20명"
                    )
                    .frame(maxWidth: .infinity)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 24)
    }
}

#Preview {
    VolunteerPostView()
}
