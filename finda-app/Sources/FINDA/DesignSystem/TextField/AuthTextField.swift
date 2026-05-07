import SwiftUI

public enum AuthTextFieldType {
    case base // 기본 텍스트 입력 필드
    case schoolEmail  // 학교 이메일 입력 필드
    case schoolVerificationEmail // 학교 이메일 인증 코드 발송 필드
    case verificationEmail // 이메일 인증 코드 발송 필드
    case password // 비밀번호 입력 필드
}

public struct AuthTextField: View {
    let type: AuthTextFieldType
    let placeholder: String
    let label: String?
    @Binding var text: String
    @Binding var isError: Bool
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
        isError: Binding<Bool> = .constant(false),
        onSendCode: (() -> Void)? = {}) {
            self.type = type
            self.placeholder = placeholder
            self.label = label
            self._text = text
            self._isError = isError
            self.onSendCode = onSendCode
        }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(labelText)
                .font(.finda(.body1))
                .foregroundColor(Color.gray80)

            HStack(spacing: 4) {
                if type == .password {
                    ZStack(alignment: .trailing) {
                        Group {
                            if !isPasswordVisible {
                                SecureField(placeholder, text: $text)
                                    .focused($isFocused)
                            } else {
                                TextField(placeholder, text: $text)
                                    .focused($isFocused)
                            }
                        }
                        .textFieldStyle(.plain)
                        .font(.system(size: 15))
                        .foregroundColor(textColor)
                        .padding(.trailing, 28)

                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            if isPasswordVisible {
                                FINDAImage("eyeOpen")
                            } else {
                                FINDAImage("eyeOff")
                            }
                        }
                        .buttonStyle(.plain)
                    }
                } else {
                    Group {
                        TextField(placeholder, text: $text)
                            .focused($isFocused)
                    }
                    .textFieldStyle(.plain)
                    .font(.system(size: 15))
                    .foregroundColor(textColor)

                    if type == .schoolEmail || type == .schoolVerificationEmail {
                        Text("@dsm.hs.kr")
                            .font(.finda(.body2))
                            .foregroundColor(Color.gray50)
                    }

                    if type == .verificationEmail || type == .schoolVerificationEmail {
                        Button(action: {
                            onSendCode?()
                            hasSentCode = true
                            startTimer()
                        }, label: {
                            Text(buttonText)
                                .font(.finda(.caption1))
                                .foregroundColor(Color.blue50)
                        })
                        .disabled(remainingSeconds > 0 || text.isEmpty)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 8)
                        .background(Color.blue10)
                        .cornerRadius(20)
                    }
                }
            }
            #if SKIP
            .padding(.leading, -16)
            .padding(.vertical, -17)
            .padding(.trailing, 0)
            #endif
            .padding(.horizontal, 16)
            .padding(.vertical, 17)
            .background(Color.gray20, in: RoundedRectangle(cornerRadius: 16))
            .overlay(alignment: .center) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(borderColor, lineWidth: 1)
            }
        }
        .onDisappear {
            timer?.invalidate()
            timer = nil
        }
    }

    private var labelText: String {
        if let label = label {
            return label
        }

        switch type {
        case .base:
            return "이메일"
        case .schoolEmail, .schoolVerificationEmail:
            return "이메일"
        case .verificationEmail:
            return "이메일"
        case .password:
            return "비밀번호"
        }
    }

    private var borderColor: Color {
        if isError {
            return Color.red20
        }
        return isFocused ? Color.blue50 : Color.gray20
    }

    private var textColor: Color {
        if isError {
            return Color.red20
        }
        return Color.black
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

struct AuthTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 24) {
            AuthTextField(
                type: .base,
                placeholder: "이메일을 입력해주세요",
                text: .constant("")
            )

            AuthTextField(
                type: .schoolVerificationEmail,
                placeholder: "이메일을 입력해주세요",
                text: .constant(""),
                onSendCode: {
                    print("코드 발송")
                }
            )

            AuthTextField(
                type: .password,
                placeholder: "비밀번호를 입력해주세요",
                text: .constant("HiMynameisHawon"),
                isError: .constant(false)
            )

            AuthTextField(
                type: .password,
                placeholder: "비밀번호를 입력해주세요",
                label: "비밀번호 확인",
                text: .constant(""),
                isError: .constant(true)
            )

            AuthTextField(
                type: .schoolEmail,
                placeholder: "이메일을 입력해주세요",
                text: .constant(""),
                isError: .constant(false)
            )
        }
        .padding()
    }
}
