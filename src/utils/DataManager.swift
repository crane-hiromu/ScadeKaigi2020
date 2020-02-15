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
    var descriptions = [Session]()
    
    func set(timetable: TimetableResponse) {
        sessions = timetable.sessions
        rooms = timetable.rooms
        speakers = timetable.speakers
        questions = timetable.questions
        categories = timetable.categories
    }
    
    func room(by id: Int64) -> String? {
        return rooms.first { $0.id == id }?.name.ja
    }
    
    func speakers(by sessionid: String) -> [Speakers] {
        return speakers.filter { sp in sp.sessions.first { $0 == sessionid }?.isEmpty == false }
    }
    
    func category(by itemId: Int64) -> Rooms? { 
    	return categories.compactMap { cat in cat.items.first { $0.id == itemId } }.first
    }
    
    func description(by id: String) -> String? {
        return descriptions.first { $0.id == id }?.description
    }
    
    func call() {
    		DispatchQueue.global().async {
    				let request = TimetablesRequest()
    		
		    		HttpClient.call(request) { [weak self] result in
		    				switch result {
		    				case let .success(response):
		    						self?.descriptions = (response as? TimetablesResponse)?.sessions ?? []
		    				case let .failure(error):
		    						debugPrint(error)
		    				}
		    		}
    		}
    }
}
