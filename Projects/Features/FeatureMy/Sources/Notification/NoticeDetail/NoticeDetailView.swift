import SwiftUI
import DesignSystem

struct NoticeDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTime = Date()

    var body: some View {
        VStack(spacing: 20) {
            FINDAHeader(
                title: "공지사항 생성",
                leftItemImage: Image.Icons.leftArrow,
                leftItemAction: { dismiss() }
            )

            VStack(spacing: 20) {
                DatePicker(
                    "시간 선택",
                    selection: $selectedTime,
                    displayedComponents: .hourAndMinute
                )
                .datePickerStyle(.wheel)
                .labelsHidden()

                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NoticeDetailView()
}
