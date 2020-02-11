import ScadeKit

// MARK: - Protocol 

protocol ClassNameProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameProtocol {
    static var className: String {
        return String(describing: self)
    }

    var className: String {
        return Self.className
    }
}

extension EObject: ClassNameProtocol {}