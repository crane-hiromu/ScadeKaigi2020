import ScadeKit

// MARK: - Adapter

final class TimeTablePageAdapter: SCDLatticePageAdapter {
	
	private var pageType: TimeTablePageType = .dayOne
	
	private var tabItems: [SCDWidgetsToolBarItem] {
		return TimeTablePageType.allCases.compactMap {
			self.page?.getWidgetByName($0.tabItem) as? SCDWidgetsToolBarItem
		}
	}
	
	private lazy var timeTableList: SCDWidgetsList! = {
        let widget = self.page?.getWidgetByName("timeTableList")
        let list = widget as? SCDWidgetsList
//        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
//        	self?.onItemSelected(with: event)
//        })
        return list
    }()
	
	// MARK: Override
	
	override func load(_ path: String) {		
		super.load(path)
		
		TimeTablePageType.allCases.forEach {
			let item = self.page?.getWidgetByName($0.tabItem) as? SCDWidgetsToolBarItem
			item?.onClick.append(SCDWidgetsEventHandler{ [weak self] _ in 
				self?.pageType = .dayOne
				self?.tabItems.forEach { $0.backgroundColor = SCDGraphicsRGB(red:255,green:255,blue:255) }
				item?.backgroundColor = SCDGraphicsRGB(red:255,green:127,blue:80)
			})
		}
		debugPrint("----load----", tabItems)
		
		
		
		let service: TimetableService? = SCDRuntime.loadService("TimetableService.service")
		let result = service?.getTimetable()
		print("-----", result)
		
		
		timeTableList.items = result?.sessions.map { $0.title } ?? []
	}
	
	override func activate(_ view: SCDLatticeView?) {
		super.activate(view)
		
		debugPrint("----activate----")
	}
	
	override func show(_ view: SCDLatticeView?, data: Any?) {
		super.show(view, data: data)
		
		debugPrint("----show data----")
	}
	
	override func show(_ view: SCDLatticeView?) {
		super.show(view)
		
		debugPrint("----show----")
	
	}
}


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
