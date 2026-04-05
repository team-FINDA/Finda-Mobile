#if !SKIP
import SwiftUI
import DesignSystem

struct NoticeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    private let mode: NoticeDetailFeature.Mode
    private let rightButtonAction: (() -> Void)?
    @State private var selectedTime = Date()
    @State private var title: String = ""
    @State private var content = ""
    @State private var selectedDate = Date()
    @State private var isDateSheetPresented = false

    init(mode: NoticeDetailFeature.Mode = .create, rightButtonAction: (() -> Void)? = nil) {
        self.mode = mode
        self.rightButtonAction = rightButtonAction

        switch mode {
        case .create:
            _title = State(initialValue: "")
            _content = State(initialValue: "")
            _selectedDate = State(initialValue: Date())
            _selectedTime = State(initialValue: Date())

        case let .edit(data):
            _title = State(initialValue: data.title)
            _content = State(initialValue: data.content)
            _selectedDate = State(initialValue: Self.parseDate(from: data.date) ?? Date())
            _selectedTime = State(initialValue: Self.parseTime(from: data.time) ?? Date())
        }
    }

    var body: some View {
        let isEditMode: Bool = {
            if case .edit = mode { return true }
            return false
        }()

        VStack(spacing: 20) {
            FINDAHeader(
                title: isEditMode ? "공지사항 수정" : "공지사항 생성",
                leftItemImage: Image.Icons.leftArrow,
                leftItemAction: { dismiss() },
                rightItemImage: isEditMode ? Image.Icons.delete : nil,
                rightItemAction: isEditMode ? (rightButtonAction ?? {}) : nil
            )

            ScrollView {
                VStack(spacing: 20) {
                    DatePicker(
                        "시간 선택",
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()

                    AuthTextField(
                        type: .base,
                        placeholder: "제목을 입력해주세요",
                        label: "제목",
                        text: $title
                    )

                    NoticeContentEditor(text: $content)

                    Button(
                        action: {
                            isDateSheetPresented = true
                        },
                        label: {
                            HStack(spacing: 8) {
                                Text("날짜")
                                    .font(.finda(.body2))
                                    .foregroundStyle(Color.Gray.gray90)

                                Spacer()

                                Text(selectedDateText)
                                    .font(.finda(.body4))
                                    .foregroundStyle(Color.Gray.gray60)

                                Image.Icons.rightArrow
                            }
                            .padding(18)
                            .background(Color.Gray.gray20)
                            .clipShape(.rect(cornerRadius: 16))
                        }
                    )
                }
            }
            .padding(.horizontal, 24)

            FINDAButton(
                buttonText: isEditMode ? "수정하기" : "생성하기",
                buttonColor: Color.Blue.blue40,
                buttonClick: {}
            )
            .padding(.bottom, 32)
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $isDateSheetPresented) {
            DatePickerBottomSheet(selectedDate: selectedDate) { pickedDate in
                selectedDate = pickedDate
            }
            .presentationDetents([.height(360)])
        }
    }
}

private extension NoticeDetailView {
    var selectedDateText: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: selectedDate)
    }

    static func parseDate(from value: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.date(from: value)
    }

    static func parseTime(from value: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.date(from: value)
    }
}

#Preview {
    NoticeDetailView(
        mode: .edit(
            .init(
                title: "환경 지킴이 활동 안내",
                content: "오늘은 운동장 주변 쓰레기 줍기 봉사입니다.",
                date: "2025.07.03",
                time: "15:10"
            )
        )
    )
}

#endif
