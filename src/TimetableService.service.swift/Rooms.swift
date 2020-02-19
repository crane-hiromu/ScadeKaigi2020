import Foundation
import ScadeKit

@objc
protocol Rooms: EObjectProtocol {
    var id: Int64 { get }
    var name: Title { get }
    var sort: Int64 { get }
}
