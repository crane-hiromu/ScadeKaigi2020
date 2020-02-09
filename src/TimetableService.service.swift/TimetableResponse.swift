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
    dynamic var sessions: [Sessions]
    dynamic var rooms: [Rooms]
    dynamic var speakers: [Speakers]
    dynamic var questions: [Questions]
    dynamic var categories: [Categories]
    
    init(_ timetableResponse: TimetableResponse) {
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
}