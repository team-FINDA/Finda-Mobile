import SwiftUI

@Observable
class MyRootViewModel {
    var role: UserRole
    var path: [MyPath] = []

    enum MyPath: Hashable {
        case setting
        case volunteerHistory
        case noticeManage
        case noticeDetail(NoticeDetailView.Mode)
        case alertSetting
        case passwordChangeEmailVerification
        case newPassword
    }

    init(role: UserRole) {
        self.role = role
    }

    func settingTapped() {
        path.append(.setting)
    }

    func myButtonTapped() {
        if role == .student {
            path.append(.volunteerHistory)
        } else {
            path.append(.noticeManage)
        }
    }

    func alertSettingTapped() {
        path.append(.alertSetting)
    }

    func noticeAddTapped() {
        path.append(.noticeDetail(.create))
    }

    func noticeItemTapped(_ item: NoticeItem) {
        path.append(.noticeDetail(.edit(.init(
            title: item.title,
            content: item.content,
            date: item.date,
            time: item.time
        ))))
    }

    func passwordChangeTapped() {
        path.append(.passwordChangeEmailVerification)
    }

    func passwordChangeEmailNextTapped() {
        path.append(.newPassword)
    }

    func backToMyRoot() {
        path = []
    }
}

public struct MyRootView: View {
    @State private var viewModel: MyRootViewModel

    public init(role: UserRole) {
        _viewModel = State(initialValue: MyRootViewModel(role: role))
    }

    public var body: some View {
        NavigationStack(path: $viewModel.path) {
            MyView(viewModel: viewModel)
                .navigationDestination(for: MyRootViewModel.MyPath.self) { path in
                    switch path {
                    case .setting:
                        SettingView(viewModel: viewModel)
                    case .volunteerHistory:
                        VolunteerHistoryView()
                    case .noticeManage:
                        NoticeManageView()
                    case .noticeDetail(let mode):
                        NoticeDetailView(mode: mode)
                    case .alertSetting:
                        AlertSettingView()
                    case .passwordChangeEmailVerification:
                        PasswordChangeEmailVerificationView(
                            role: viewModel.role,
                            onNextTapped: { viewModel.passwordChangeEmailNextTapped() }
                        )
                    case .newPassword:
                        NewPasswordView(
                            onChangeTapped: { viewModel.backToMyRoot() }
                        )
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
    }
}
