import Foundation
import ScadeKit

@objc
protocol TimetableResponse: EObjectProtocol {
    var sessions: [Sessions] { get }
    var rooms: [Rooms] { get }
    var speakers: [Speakers] { get }
    var questions: [Questions] { get }
    var categories: [Categories] { get }
}

@objcMembers
final class TimetableEntity: EObject {
    private let sessionsEntiry: [Sessions]
    
    dynamic var sessions: [Sessions]
    dynamic var rooms: [Rooms]
    dynamic var speakers: [Speakers]
    dynamic var questions: [Questions]
    dynamic var categories: [Categories]
    
    override init() {
        self.sessionsEntiry = []
        self.sessions = []
        self.rooms = []
        self.speakers = []
        self.questions = []
        self.categories = []
    }
    
    init(_ timetableResponse: TimetableResponse) {
        self.sessionsEntiry = timetableResponse.sessions
        self.sessions = timetableResponse.sessions
        self.rooms = timetableResponse.rooms
        self.speakers = timetableResponse.speakers
        self.questions = timetableResponse.questions
        self.categories = timetableResponse.categories
    }
    
    func room(by id: Int64) -> String? {
        return rooms.first { $0.id == id }?.name.ja
    }
    
    func speakers(by sessionid: String) -> [Speakers] {
        return speakers.filter { $0.sessions.first { $0 == sessionid }?.isEmpty == false }
    }
    
    func update(type: Constants.TimeTablePageType) {
        switch type {
        case .dayOne:
            self.sessions = sessionsEntiry.filter { $0.startsAt.contains("02-20T") }
        case .dayTwo:
            self.sessions = sessionsEntiry.filter { $0.startsAt.contains("02-21T") }
        case .event:
            self.sessions = []
        case .myPlan:
            self.sessions = sessionsEntiry.filter { 
                UserDefaultsHelper.sessionIds.arrayString?.contains($0.id) == true 
            }
        }
    }
}
