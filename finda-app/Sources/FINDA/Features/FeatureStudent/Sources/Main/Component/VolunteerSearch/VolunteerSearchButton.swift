import SwiftUI

struct VolunteerSearchButton: View {
    var action: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("참여중인 봉사활동이 없다면?")
                    .font(.finda(.body1))
                    .foregroundColor(.gray80)

                Button(action: action) {
                    Text("봉사 게시물 찾기")
                        .font(.finda(.body3))
                        .foregroundColor(.gray10)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 8)
                }
                .background(Color.blue50)
                .cornerRadius(32)
            }
            .padding(.trailing, 24)

            Spacer()

            FINDAImage("findVolunteer")
                .padding(.leading, 20)
                .padding(.vertical, 13)
        }
        .padding(.horizontal, 20)
        .background(Color.blue10)
        .cornerRadius(20)
    }
}
