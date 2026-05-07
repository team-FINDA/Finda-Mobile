import SwiftUI

@Observable
class AuthViewModel {
    var selectedRole: UserRole?
    var path: [AuthPath] = []
    private let onAuthenticated: ((UserRole) -> Void)?

    init(onAuthenticated: ((UserRole) -> Void)? = nil) {
        self.onAuthenticated = onAuthenticated
    }
    
    enum AuthPath: Hashable {
        case signin(UserRole)
        case signupUserSelect
        case secretKey
        case emailVerification
        case information
    }
    
    func studentSigninTapped() {
        selectedRole = .student
        path.append(.signin(.student))
    }
    
    func teacherSigninTapped() {
        selectedRole = .teacher
        path.append(.signin(.teacher))
    }
    
    func signupTapped() {
        path.append(.signupUserSelect)
    }
    
    func studentSignupTapped() {
        selectedRole = .student
        path.append(.emailVerification)
    }
    
    func teacherSignupTapped() {
        selectedRole = .teacher
        path.append(.secretKey)
    }
    
    func secretKeyNextTapped() {
        path.append(.emailVerification)
    }
    
    func emailVerificationNextTapped() {
        path.append(.information)
    }
    
    func backToRoot() {
        selectedRole = nil
        path = []
    }

    func completeAuthentication(role: UserRole) {
        selectedRole = role
        onAuthenticated?(role)
    }

    func completeSignup() {
        guard let role = selectedRole else { return }
        onAuthenticated?(role)
    }
}

public struct AuthRootView: View {
    @State private var viewModel: AuthViewModel

    public init(onAuthenticated: ((UserRole) -> Void)? = nil) {
        _viewModel = State(initialValue: AuthViewModel(onAuthenticated: onAuthenticated))
    }
    
    public var body: some View {
        NavigationStack(path: $viewModel.path) {
            SigninUserSelectView(viewModel: viewModel)
                .navigationDestination(for: AuthViewModel.AuthPath.self) { path in
                    switch path {
                    case .signin(let role):
                        SigninView(role: role, viewModel: viewModel)
                    case .signupUserSelect:
                        SignupUserSelectView(viewModel: viewModel)
                    case .secretKey:
                        SecretKeyView(viewModel: viewModel)
                    case .emailVerification:
                        EmailVerificationView(viewModel: viewModel)
                    case .information:
                        InformationView(viewModel: viewModel)
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.gray10.ignoresSafeArea())
    }
}
