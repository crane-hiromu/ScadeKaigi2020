
import ScadeKit

/* https://app.swaggerhub.com/apis/jmatsu/droidkaigi/2020 */

struct Constants {
	
		// MARK: Structs	
	
    struct API {
        static let baseURL: String = "https://api.droidkaigi.jp/2020/"
    }
    
    struct Tag {
    		static let on: String = "res/iconTagOn.png"
    		static let off: String = "res/iconTagOff.png"
    		
    		static func icon(by id: String) -> String {
    				let contains = UserDefaultsHelper.sessionIds.arrayString?.contains(id)
    				return (contains == true) ? on : off
    		}
    }
    
    // MARK: Enums
    
    enum TimeTablePageType: String, CaseIterable {
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
    
		#if os(iOS)
    static var hasNotch: Bool {
        return 20.0 < UIApplication.shared.statusBarFrame.height // todo
    }
    #endif
}