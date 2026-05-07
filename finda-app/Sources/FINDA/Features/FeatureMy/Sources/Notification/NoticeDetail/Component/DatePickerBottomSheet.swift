import SwiftUI

struct DatePickerBottomSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var draftDate: Date
    let onConfirm: (Date) -> Void

    init(selectedDate: Date, onConfirm: @escaping (Date) -> Void) {
        self._draftDate = State(initialValue: selectedDate)
        self.onConfirm = onConfirm
    }

    var body: some View {
        VStack(spacing: 40) {
            DatePicker(
                "날짜 선택",
                selection: $draftDate,
                displayedComponents: .date
            )
            #if !SKIP
            .datePickerStyle(.wheel)
            #endif
            .labelsHidden()
            .environment(\.locale, Locale(identifier: "ko_KR"))
            .labelsHidden()
            .environment(\.locale, Locale(identifier: "ko_KR"))

            FINDAButton(
                buttonText: "선택 완료",
                buttonClick: {
                    onConfirm(draftDate)
                    dismiss()
                }
            )
            .padding(.horizontal, 24)
        }
        .padding(.top, 16)
    }
}
