import SwiftUI
import DesignSystem

struct NoticeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTime = Date()
    @State private var title: String = ""
    @State private var content = ""
    @State private var selectedDate = Date()
    @State private var isDateSheetPresented = false

    init() {}

    var body: some View {
        VStack(spacing: 20) {
            FINDAHeader(
                title: "공지사항 생성",
                leftItemImage: Image.Icons.leftArrow,
                leftItemAction: { dismiss() }
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
                buttonText: "생성하기",
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
}

#Preview {
    NoticeDetailView()
}
