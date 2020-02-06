import Foundation
import ScadeKit

@objc
protocol Asset: EObjectProtocol {
  var videoUrl: String { get }

  var slideUrl: String { get }
}
