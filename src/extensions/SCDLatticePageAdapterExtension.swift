import ScadeKit
import Foundation

// MARK: - Adapter Extension

extension SCDLatticePageAdapter {
	
	/* example
	
	MainPageAdapter
	-> main_page_adapter
	-> ["", "main", "page", "adapter"]
	-> ["", "main", "page"]
	-> ["", "main"]
	-> "main.page"
	
	*/
	
//    static var pageName: String {
//    	var names = self.className.camelToSnake.components(separatedBy: "_")
//    	guard 0 < names.count else { return "" }
//    	
//    	if names[(names.count-1)] == "adapter" { names.removeLast() }
//    	if names[(names.count-1)] == "page" { names.removeLast() }
//
//    	let result = names.reduce("") { $0 + $1 }
////    	debugPrint("---- SCDLatticePageAdapter page: \(result) ----")
//    	
//    	return "\(result).page"
//    }

		func setupSafeArea() {
				// todo name
				
				let content = self.page?.getWidgetByName("statusBarContent")?.asRow?.layoutData?.asGridData
				let notch = self.page?.getWidgetByName("statusBarNotch")?.asRow?.layoutData?.asGridData
				
				#if(os(Android))	
						content?.isExclude = true
						notch?.isExclude = true
				#else
						content?.isExclude = false
						notch?.isExclude = !Constants.hasNotch
				#endif
		}
}