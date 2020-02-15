import ScadeKit

// MARK: - Entity

@objcMembers
final class TimetableEntity: EObject {
    private let dayOneSessionsEntity: [Sessions]
    private let dayTwoSessionsEntity: [Sessions]
    private let eventSessionsEntity: [Sessions]    
    
    dynamic var sessions: [Sessions]
    dynamic var rooms: [Rooms]
    dynamic var speakers: [Speakers]
    dynamic var questions: [Questions]
    dynamic var categories: [Categories]
    
    override init() {
        self.sessions = []
        self.rooms = []
        self.speakers = []
        self.questions = []
        self.categories = []
        
        self.dayOneSessionsEntity = []
        self.dayTwoSessionsEntity = []
        self.eventSessionsEntity = []
    }
    
    init(_ timetableResponse: TimetableResponse) {
        self.sessions = timetableResponse.sessions
        self.rooms = timetableResponse.rooms
        self.speakers = timetableResponse.speakers
        self.questions = timetableResponse.questions
        self.categories = timetableResponse.categories
        
        /// calculate first, case of to load view quickly by cache
        self.dayOneSessionsEntity = timetableResponse.sessions.filter { $0.startsAt.contains("02-20T") }
        self.dayTwoSessionsEntity = timetableResponse.sessions.filter { $0.startsAt.contains("02-21T") }
        self.eventSessionsEntity = timetableResponse.sessions.filter { $0.isServiceSession }
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
            self.sessions = dayOneSessionsEntity
        case .dayTwo:
            self.sessions = dayTwoSessionsEntity
        case .event:
            self.sessions = eventSessionsEntity
        case .myPlan:
            self.sessions = self.sessions.filter { 
                UserDefaultsHelper.sessionIds.arrayString?.contains($0.id) == true 
            }
        }
    }
}
