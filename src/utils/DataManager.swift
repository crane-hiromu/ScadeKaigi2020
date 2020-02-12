import ScadeKit

// MARK: - Manager

final class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    var sessions = [Sessions]()
    var rooms = [Rooms]()
    var speakers = [Speakers]()
    var questions = [Questions]()
    var categories = [Categories]()
    
    func set(timetable: TimetableResponse) {
        sessions = timetable.sessions
        rooms = timetable.rooms
        speakers = timetable.speakers
        questions = timetable.questions
        categories = timetable.categories
    }
}
