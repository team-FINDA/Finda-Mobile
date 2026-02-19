import SwiftUI
import DesignSystem
import Shared

public struct MyView: View {
    private let role: UserRole
    private let studentName = "2216 하원"
    private let interests = ["환경지킴이", "바둑두기", "바둑두기", "바둑두기"]

    public init(role: UserRole) {
        self.role = role
    }

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image.Images.baseProfile
                    .resizable()
                    .frame(width: 48, height: 48)
                    .clipShape(Circle())

                VStack(alignment: .leading, spacing: 4) {
                    Text(studentName)
                        .font(.finda(.body1))
                        .foregroundColor(.Gray.gray90)

                    if role == .student {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(Array(interests.enumerated()), id: \.offset) { _, interest in
                                    HStack(spacing: 8) {
                                        Circle()
                                            .fill(Color.Blue.blue40)
                                            .frame(width: 4, height: 4)

                                        Text(interest)
                                            .font(.finda(.caption1))
                                            .foregroundColor(.Gray.gray60)
                                    }
                                }
                            }
                        }
                    }
                }
                Spacer()

                Button(action: {}, label: {
                    Image.Icons.setting
                })
            }

            Spacer()
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
}

#Preview {
    MyView(role: .student)
}
