import Foundation
import ScadeKit

@objc
protocol Speakers: EObjectProtocol {
  var id: String { get }
  var firstName: String { get }
  var lastName: String { get }
  var bio: String { get }
  var tagLine: String { get }
  var profilePicture: String { get }
  var isTopSpeaker: Bool { get }
  var sessions: [String] { get }
  var fullName: String { get }
}
