// finda-app/Sources/FINDA/Core/Model/NoticeItem.swift
import Foundation

public struct NoticeItem: Equatable, Identifiable {
    public let id: String
    public let title: String
    public let content: String
    public let date: String
    public let time: String

    public init(id: String, title: String, content: String, date: String, time: String) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.time = time
    }
}

public struct VolunteerListResponse: Identifiable {
    public let id: String
    public let title: String
    public let startDate: String
    public let endDate: String
    public let status: VolunteerStatus
}

public enum VolunteerStatus: String, CaseIterable {
    case all = "전체"
    case waiting = "대기중"
    case inProgress = "진행중"
    case ended = "종료"
}
