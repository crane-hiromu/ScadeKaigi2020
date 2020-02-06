import Foundation
import ScadeKit

@objc
protocol TimetableService: EObjectProtocol {
  func getTimetable() -> TimetableResponse!
}
