import Foundation

// MARK: - Helper

enum UserDefaultsHelper: String {
    case sessionIds
    
    func setItem<T>(with item: T) {
        UserDefaults.standard.set(item, forKey: rawValue)
    }
    
    var string: String? {
        return UserDefaults.standard.string(forKey: rawValue)
    }
    
    var int: Int {
        return UserDefaults.standard.integer(forKey: rawValue)
    }
    
    var bool: Bool {
        return UserDefaults.standard.bool(forKey: rawValue)
    }
    
    var date: Date? {
        return UserDefaults.standard.object(forKey: rawValue) as? Date
    }
    
    var arrayString: [String]? {
        return UserDefaults.standard.array(forKey: rawValue) as? [String]
    }
}
