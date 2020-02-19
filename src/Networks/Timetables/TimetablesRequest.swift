import Foundation

// MARK: - Request

struct TimetablesRequest: BaseRequestProtocol {
    
    typealias ResponseType = TimetablesResponse
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "timetable/"
    }
    
    var parameters: Parameters? {
        return nil
    }
}

