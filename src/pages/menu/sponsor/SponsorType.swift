import ScadeKit

// MARK: - Type

enum SponsorType {
    case platinum(PlatinumType)
    case gold(GoldType)
    case supporter(SupporterType)
    
    var name: String {
        switch self {
        case let .platinum(type): return type.name
        case let .gold(type): return type.name
        case let .supporter(type): return type.name
        }
    }
    
    var url: String {
        switch self {
        case let .platinum(type): return type.url
        case let .gold(type): return type.url
        case let .supporter(type): return type.url
        }
    }
    
    var logo: String {
        switch self {
        case let .platinum(type): return type.logo
        case let .gold(type): return type.logo
        case let .supporter(type): return type.logo
        }
    }
}

enum PlatinumType {
    case zozo, yappli, yumemi
    
    var name: String {
        switch self {
        case .zozo: return "株式会社ZOZOテクノロジーズ"
        case .yappli: return "株式会社ヤプリ"
        case .yumemi: return "株式会社ゆめみ"
        }
    }
    
    var url: String {
        switch self {
        case .zozo: return "https://corp.zozo.com/"
        case .yappli: return "https://yappli.co.jp/"
        case .yumemi: return "https://www.yumemi.co.jp/ja"
        }
    }
    
    var logo: String {
        switch self {
        case .zozo: return ""
        case .yappli: return ""
        case .yumemi: return ""
        }
    }
}

enum GoldType {
    
    var name: String {
        return ""
    }
    
    var url: String {
        return ""
    }
    
    var logo: String {
        return ""
    }
}

enum SupporterType {
    
    var name: String {
        return ""
    }
    
    var url: String {
        return ""
    }
    
    var logo: String {
        return ""
    }
}
