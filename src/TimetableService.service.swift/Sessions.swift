import Foundation
import ScadeKit

@objc
protocol Sessions: EObjectProtocol {
  var id: String { get }
  var title: Title { get }
//  var description: String { get } // fail to parse so getting other api
  var startsAt: String { get }
  var endsAt: String { get }
  var isServiceSession: Bool { get }
  var isPlenumSession: Bool { get }
  var roomId: Int64 { get }
  var targetAudience: String { get }
  var language: String { get }
  var lengthInMinutes: Int64 { get }
  var sessionCategoryItemId: Int64 { get }
  var interpretationTarget: Bool { get }
  var asset: Asset { get }
  var message: String { get }
  var sessionType: String { get }
  var levels: [String] { get }
  var speakers: [String] { get }
}
