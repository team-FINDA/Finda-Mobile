#if !SKIP && canImport(UIKit)
import ComposableArchitecture

@Reducer
public struct AlertSettingFeature {
    public struct VolunteerAlertItem: Equatable, Identifiable, Sendable {
        public let id: String
        public let title: String
        public var isOn: Bool

        public init(id: String, title: String, isOn: Bool) {
            self.id = id
            self.title = title
            self.isOn = isOn
        }
    }

    @ObservableState
    public struct State: Equatable {
        public var noticeToggleOn: Bool
        public var totalToggleOn: Bool
        public var volunteerAlertItems: [VolunteerAlertItem]

        public init(
            noticeToggleOn: Bool = false,
            totalToggleOn: Bool = false,
            volunteerAlertItems: [VolunteerAlertItem] = Self.defaultVolunteerAlertItems
        ) {
            self.noticeToggleOn = noticeToggleOn
            self.totalToggleOn = totalToggleOn
            self.volunteerAlertItems = volunteerAlertItems
        }

        public static let defaultVolunteerAlertItems: [VolunteerAlertItem] = [
            .init(id: "1", title: "환경 지킴이 활동", isOn: false),
            .init(id: "2", title: "교감쌤과 바둑두기", isOn: true),
            .init(id: "3", title: "화단에 물주기", isOn: false)
        ]
    }

    public enum Action {
        case noticeToggleChanged(Bool)
        case totalToggleChanged(Bool)
        case volunteerToggleChanged(id: String, isOn: Bool)
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .noticeToggleChanged(isOn):
                state.noticeToggleOn = isOn
                return .none

            case let .totalToggleChanged(isOn):
                state.totalToggleOn = isOn
                guard isOn else { return .none }
                for index in state.volunteerAlertItems.indices {
                    state.volunteerAlertItems[index].isOn = true
                }
                return .none

            case let .volunteerToggleChanged(id, isOn):
                guard let index = state.volunteerAlertItems.firstIndex(where: { $0.id == id }) else {
                    return .none
                }
                state.volunteerAlertItems[index].isOn = isOn
                state.totalToggleOn = state.volunteerAlertItems.allSatisfy(\.isOn)
                return .none
            }
        }
    }
}

#endif
