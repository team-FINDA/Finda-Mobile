import SwiftUI

@Observable
class AuthViewModel {
    var selectedRole: UserRole?
    var path: [AuthPath] = []
    
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
}

public struct AuthRootView: View {
    @State private var viewModel = AuthViewModel()
    
    public init() {}
    
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
    }
}
