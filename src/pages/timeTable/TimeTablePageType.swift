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
		case home, info, map
		
		var target: Constants.PageType {
				switch self {
				case .home: return .timeTable
				case .info: return .timeTable
				case .map: return .map
				}
		}
}