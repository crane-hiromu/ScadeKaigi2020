import ScadeKit

// MARK: - Type

enum TimeTablePageType: Int, CaseIterable {
    case dayOne, dayTwo, event, myPlan
    
    var tabItem: String {
        switch self {
        case .dayOne: return "tabItemDayOne"
        case .dayTwo: return "tabItemDayTwo"
        case .event: return "tabItemEvent"
        case .myPlan: return "tabItemMyPlan"
        }
    }
}
enum MenuPageType: Int, CaseIterable {
		case home, about, info, map, sponsor
		
		var target: Constants.PageType {
				switch self {
				case .home: return .timeTable
				case .about: return .about
				case .info: return .timeTable // todo
				case .map: return .map
				case .sponsor: return .sponsor
				}
		}
}