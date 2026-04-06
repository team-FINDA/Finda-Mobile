#if !SKIP && canImport(UIKit)
import SwiftUI

struct VolunteerPostView: View {
    @Environment(\.dismiss) private var dismiss
    private let activityTags = ["교장실", "상담실 분리수거", "제2 교무실", "제3 교무실", "청죽관 분리수거", "교실 분리수거"]

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }, label: {
                    Image("leftArrow")
                        .foregroundStyle(Color.gray80)
                })

                Spacer()

                Text("봉사활동 제목??")
                    .font(.finda(.body1))
                    .foregroundColor(.gray90)

                Spacer()

                Image("leftArrow")
                    .opacity(0)
                    .accessibilityHidden(true)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 8)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("봉사활동 제목")
                            .font(.finda(.heading5))
                            .foregroundColor(.gray90)
                        Text("봉사활동 내용입니다.")
                            .font(.finda(.body4))
                            .foregroundColor(.gray90)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)

                    VStack(spacing: 15) {
                        HStack(spacing: 13) {
                            InfoView(
                                icon: Image("calendar"),
                                title: "신청 기간",
                                content: "2025.3.10 ~\n2025.3.12",
                                date: true
                            )
                            .frame(maxWidth: .infinity)
                            InfoView(
                                icon: Image("calendar"),
                                title: "활동 기간",
                                content: "2025.3.10 ~\n2025.3.12",
                                date: true
                            )
                            .frame(maxWidth: .infinity)
                        }
                        HStack(spacing: 13) {
                            InfoView(
                                icon: Image("time"),
                                title: "봉사 기간",
                                content: "8시간"
                            )
                            .frame(maxWidth: .infinity)
                            InfoView(
                                icon: Image("people"),
                                title: "활동 기간",
                                content: "20명"
                            )
                            .frame(maxWidth: .infinity)
                        }
                    }

                    ActivityTagSection(tags: activityTags)

                    Text("활동 장소")
                        .font(.finda(.caption1))
                        .foregroundColor(.gray60)

                    HStack(spacing: 18) {
                        Image("location")
                        Text("대덕소프트웨어마이스터고")
                            .font(.finda(.body3))
                            .foregroundColor(.gray90)
                        Spacer()
                    }
                    .padding(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color.gray70, lineWidth: 0.5)
                    )

                    Spacer()
                }
                .padding(.horizontal, 24)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)

        FINDAButton(
            buttonText: "신청",
            buttonColor: Color.blue40,
            buttonClick: {}
        )
            .padding(20)
    }
}

#Preview {
    VolunteerPostView()
}

#endif
