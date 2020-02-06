import Foundation

// MARK: - Response

struct SpeakersResponse: Codable {
    var speakers: [Speaker]
}

struct Speaker: Codable {
    let id: String
    let firstName: String
    let lastName: String
    let bio: String
    let tagLine: String
    let profilePicture: String?
    let isTopSpeaker: Bool
    let sessions: [String]
    let fullName: String
}
