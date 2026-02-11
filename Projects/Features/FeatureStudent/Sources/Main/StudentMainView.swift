import SwiftUI
import DesignSystem

public struct StudentMainView: View {
    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    Image.Images.baseProfile
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome,")
                            .font(.finda(.body4))
                            .foregroundStyle(Color.Gray.gray60)
                        Text("2216 하원")
                            .font(.finda(.body1))
                    }

                    Spacer()

                    Button { } label: {
                        Image.Icons.bell
                    }

                }
                .padding(.top, 20)

                HStack(spacing: 3.5) {
                    Image.Icons.speakerphone

                    Text("FINDA에 새로운 기능이 추가되었어요!")
                        .font(.finda(.body4))
                        .foregroundStyle(Color.Gray.gray80)

                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 9)
                .background(Color.Blue.blue10.cornerRadius(20))

                TotalTimeView(volunteerTime: 16)

                Spacer()
            }
            .padding(.horizontal, 24.5)
        }
    }
}

#Preview {
    StudentMainView()
}
