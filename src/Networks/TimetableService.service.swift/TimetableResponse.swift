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
