import ScadeKit
import Foundation

extension SCDLatticeNavigation {
    
    enum Transition: String {
        case normal, forward = "FORWARD_PUSH", back = "BACKWARD_PUSH"
    }
    
    func push(page: String, data: Any? = nil, transition: Transition = .normal) {
        switch transition {
        case .normal:
            self.go(with: page, data: data)
        case .forward, .back:
            self.go(with: page, data: data, transition: transition.rawValue)
        }
    }
    
    func push(type: Constants.PageType, data: Any? = nil, transition: Transition = .normal) {
        push(page: type.page, data: data, transition: transition)
    }
}
