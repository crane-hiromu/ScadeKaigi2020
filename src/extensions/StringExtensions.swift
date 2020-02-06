
import Foundation

// MARK: - Extensions

extension String {
	
    var camelToSnake: String {
		return self.replacingOccurrences(
			of: "([A-Z])",
			with: "_$1",
			options: .regularExpression,
			range: self.startIndex ..< self.endIndex
		).lowercased()
    }
}