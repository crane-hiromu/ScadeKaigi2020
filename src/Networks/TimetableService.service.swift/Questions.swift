import Foundation
import ScadeKit

@objc
protocol Questions: EObjectProtocol {
  var id: Int64 { get }

  var question: Title { get }

  var questionType: String { get }

  var sort: Int64 { get }
}
