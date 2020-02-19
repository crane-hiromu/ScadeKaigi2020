import Foundation
import ScadeKit

@objc
protocol Categories: EObjectProtocol {
    var id: Int64 { get }
    var title: Title { get }
    var sort: Int64 { get }
    var items: [Rooms] { get }
}
