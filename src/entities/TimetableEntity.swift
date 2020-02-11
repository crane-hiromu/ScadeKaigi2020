import ScadeKit

// MARK: - Entity

@objcMembers
final class TimetableEntity: EObject {
    private let sessionsEntity: [Sessions]
    
    dynamic var sessions: [Sessions]
    dynamic var rooms: [Rooms]
    dynamic var speakers: [Speakers]
    dynamic var questions: [Questions]
    dynamic var categories: [Categories]
    
    override init() {
        self.sessionsEntity = []
        self.sessions = []
        self.rooms = []
        self.speakers = []
        self.questions = []
        self.categories = []
    }
    
    init(_ timetableResponse: TimetableResponse) {
        self.sessionsEntity = timetableResponse.sessions
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
    
    func update(type: TimeTablePageType) {
        switch type {
        case .dayOne:
            self.sessions = sessionsEntity.filter { $0.startsAt.contains("02-20T") }
        case .dayTwo:
            self.sessions = sessionsEntity.filter { $0.startsAt.contains("02-21T") }
        case .event:
            self.sessions = [] // todo
        case .myPlan:
            self.sessions = sessionsEntity.filter { 
                UserDefaultsHelper.sessionIds.arrayString?.contains($0.id) == true 
            }
        }
    }
}
