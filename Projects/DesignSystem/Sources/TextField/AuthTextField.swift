import SwiftUI

public enum AuthTextFieldType {
    case base // 기본 텍스트 입력 필드
    case schoolEmail  // 학교 이메일 입력 필드
    case verificationEmail // 이메일 인증 코드 발송 필드
    case password // 비밀번호 입력 필드
}

public struct AuthTextField: View {
    let type: AuthTextFieldType
    let placeholder: String
    let label: String?
    @Binding var text: String
    var onSendCode: (() -> Void)?

    @State private var isPasswordVisible = false
    @State private var remainingSeconds: Int = 0
    @State private var hasSentCode: Bool = false
    @State private var timer: Timer?
    @FocusState private var isFocused: Bool

    public init(
        type: AuthTextFieldType,
        placeholder: String,
        label: String? = nil,
        text: Binding<String>,
        onSendCode: (() -> Void)? = {}) {
            self.type = type
            self.placeholder = placeholder
            self.label = label
            self._text = text
            self.onSendCode = onSendCode
        }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(labelText)
                .font(.finda(.body1))
                .foregroundColor(DesignSystemAsset.Gray.gray80.swiftUIColor)

            HStack(spacing: 12) {
                Group {
                    if type == .password && !isPasswordVisible {
                        SecureField(placeholder, text: $text)
                            .focused($isFocused)
                    } else {
                        TextField(placeholder, text: $text)
                            .focused($isFocused)
                    }
                }
                .font(.system(size: 15))
                .foregroundColor(.black)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .keyboardType(keyboardType)

                if type == .password {
                    Button {
                        isPasswordVisible.toggle()
                    } label: {
                        (
                            isPasswordVisible
                            ? DesignSystemAsset.Icons.eyeOpen.swiftUIImage
                            : DesignSystemAsset.Icons.eyeOff.swiftUIImage
                        )
                    }
                } else if type == .schoolEmail {
                    Text("@dsm.hs.kr")
                        .font(.finda(.body2))
                        .foregroundColor(DesignSystemAsset.Gray.gray50.swiftUIColor)
                } else if type == .verificationEmail {
                    Button(action: {
                        onSendCode?()
                        hasSentCode = true
                        startTimer()
                    }, label: {
                        Text(buttonText)
                            .font(.finda(.caption1))
                            .foregroundColor(DesignSystemAsset.Blue.blue50.swiftUIColor)
                    })
                    .disabled(remainingSeconds > 0)
                    .padding(.vertical, 4)
                    .padding(.horizontal, 8)
                    .background(DesignSystemAsset.Blue.blue10.swiftUIColor)
                    .cornerRadius(20)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 17)
            .background(DesignSystemAsset.Gray.gray20.swiftUIColor)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: 1)
            )
        }
    }

    private var labelText: String {
        if let label = label {
            return label
        }

        switch type {
        case .base:
            return "이메일"
        case .schoolEmail:
            return "학교 이메일"
        case .verificationEmail:
            return "이메일"
        case .password:
            return "비밀번호"
        }
    }

    private var keyboardType: UIKeyboardType {
        switch type {
        case .schoolEmail, .verificationEmail, .base:
            return .emailAddress
        case .password:
            return .default
        }
    }

    private var borderColor: Color {
        isFocused ? DesignSystemAsset.Blue.blue50.swiftUIColor : DesignSystemAsset.Gray.gray20.swiftUIColor
    }

    private var buttonText: String {
        if remainingSeconds > 0 {
            let minutes = remainingSeconds / 60
            let seconds = remainingSeconds % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }

        return hasSentCode ? "재발송" : "코드 발송"
    }

    private func startTimer() {
        remainingSeconds = 60
        timer?.invalidate()

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
}

private struct AuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            AuthTextField(
                type: .base,
                placeholder: "이메일을 입력해주세요",
                text: .constant("")
            )

            AuthTextField(
                type: .verificationEmail,
                placeholder: "이메일을 입력해주세요",
                text: .constant(""),
                onSendCode: {
                    print("코드 발송")
                }
            )

            AuthTextField(
                type: .password,
                placeholder: "비밀번호를 입력해주세요",
                text: .constant("HiMynameisHawon")
            )

            AuthTextField(
                type: .password,
                placeholder: "비밀번호를 입력해주세요",
                label: "비밀번호 확인",
                text: .constant("")
            )

            AuthTextField(
                type: .schoolEmail,
                placeholder: "이메일을 입력해주세요",
                text: .constant("")
            )
        }
        .padding()
    }
}
