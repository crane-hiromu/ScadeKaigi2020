import Foundation

// MARK: - Response

struct TimetablesResponse: Codable {
    var sessions: [Session]
}

struct Session: Codable {
    var id: String
    var description: String?
}
