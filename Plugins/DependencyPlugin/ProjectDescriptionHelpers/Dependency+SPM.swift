import ProjectDescription

public extension TargetDependency {
    static let tca: TargetDependency = .external(name: "ComposableArchitecture")
    static let moya: TargetDependency = .external(name: "Moya")
    static let keychain: TargetDependency = .external(name: "KeychainSwift")
    static let kingfisher: TargetDependency = .external(name: "Kingfisher")
}
