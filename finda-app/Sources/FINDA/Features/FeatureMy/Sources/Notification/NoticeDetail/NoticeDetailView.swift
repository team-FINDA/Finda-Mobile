import SwiftUI

struct NoticeDetailView: View {
    @Environment(\.dismiss) private var dismiss

    enum Mode: Hashable {
        case create
        case edit(EditData)

        struct EditData: Hashable {
            let title: String
            let content: String
            let date: String
            let time: String
        }
    }

    let mode: Mode
    @State private var title: String
    @State private var content: String
    @State private var selectedDate: Date
    @State private var selectedTime: Date
    @State private var isDateSheetPresented = false

    init(mode: Mode = .create) {
        self.mode = mode
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

    var isEditMode: Bool {
        if case .edit = mode { return true }
        return false
    }

    var body: some View {
        VStack(spacing: 20) {
            FINDAHeader(
                title: isEditMode ? "공지사항 수정" : "공지사항 생성",
                leftItemImage: FINDAImage("leftArrow"),
                leftItemAction: { dismiss() },
                rightItemImage: isEditMode ? FINDAImage("delete") : nil,
                rightItemAction: isEditMode ? { } : nil
            )

            ScrollView {
                VStack(spacing: 20) {
                    DatePicker(
                        "시간 선택",
                        selection: $selectedTime,
                        displayedComponents: .hourAndMinute
                    )
                    #if !SKIP
                    .datePickerStyle(.wheel)
                    #endif
                    .labelsHidden()

                    AuthTextField(
                        type: .base,
                        placeholder: "제목을 입력해주세요",
                        label: "제목",
                        text: $title
                    )

                    NoticeContentEditor(text: $content)

                    Button(action: { isDateSheetPresented = true }) {
                        HStack(spacing: 8) {
                            Text("날짜")
                                .font(.finda(.body2))
                                .foregroundStyle(Color.gray90)
                            Spacer()
                            Text(selectedDateText)
                                .font(.finda(.body4))
                                .foregroundStyle(Color.gray60)
                            FINDAImage("rightArrow")
                        }
                        .padding(18)
                        .background(Color.gray20)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
            }
            .padding(.horizontal, 24)

            FINDAButton(
                buttonText: isEditMode ? "수정하기" : "생성하기",
                buttonColor: Color.blue40,
                buttonClick: {}
            )
            .padding(.bottom, 32)
            .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $isDateSheetPresented) {
            DatePickerBottomSheet(selectedDate: selectedDate) { pickedDate in
                selectedDate = pickedDate
            }
            .presentationDetents([.height(360)])
        }
    }

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
