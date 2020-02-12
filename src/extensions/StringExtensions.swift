
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
    
    var toTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ'"
        guard let date = formatter.date(from: self) else { return "" }
        
        formatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "HH:mm",
            options: 0, 
            locale: Locale(identifier: "ja_JP")
        )
        return formatter.string(from: date).description
    }
    
    var toDateAndTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ'"
        guard let date = formatter.date(from: self) else { return "" }
        
        formatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "MM月dd日 HH:mm",
            options: 0, 
            locale: Locale(identifier: "ja_JP")
        )
        return formatter.string(from: date).description
    }
}
