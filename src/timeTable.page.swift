import ScadeKit

// MARK: - Adapter

final class TimeTablePageAdapter: SCDLatticePageAdapter {
	
	// MARK: Properties
	
	@objc dynamic private var timetable: Timetable?	
	private var bindables = Set<SCDBindingBinding>()
	
	private var pageType: TimeTablePageType = .dayOne
	
	private var tabItems: [SCDWidgetsToolBarItem] {
		return TimeTablePageType.allCases.compactMap {
			self.page?.getWidgetByName($0.tabItem) as? SCDWidgetsToolBarItem
		}
	}
	
	private lazy var timeTableList: SCDWidgetsList! = {
        let widget = self.page?.getWidgetByName("timeTableList")
        let list = widget as? SCDWidgetsList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
        	self?.onItemSelected(with: event)
        })
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
				
				// todo reset data
//				self?.bindables.forEach { $0.deactivate() }
			})
		}
		debugPrint("----load----", tabItems)
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
	
		let service: TimetableService? = SCDRuntime.loadService("TimetableService.service")
		
		guard let result = service?.getTimetable() else { return }
		timetable = Timetable(result)
		
		
//			print(timetable?.sessions.first) 
//			print(timetable?.speakers.first) 
//			print(timetable?.rooms.first) 
//			print(timetable?.questions.first) 
//			print(timetable?.categories.first) 
		
		from(timetable!) // todo
			.select(\.sessions)
			.cast([Any].self)
			.bind(to: from(timeTableList).select(\.items))
			.registered(with: &bindables)
			
		let row = from(timeTableList).rows.cast(TimeTablePageListElement.self)
		
		from(timeTableList).items
			.select(\Sessions.title.ja)
			.bind(to: row.title)
			.registered(with: &bindables)
							
		from(timeTableList).items
			.select(\Sessions.lengthInMinutes)
			.bind(to: row.time, mapFunction: { "\($0)" })
			.registered(with: &bindables)
//			
//		self.timeTableList.elements.enumerated().forEach { i, row in
////            let label = row.children.first?.asList?.children.first?.asRow?.children.first?.asLabel
//          	print("------", row.children.first?.asRow)
//			print("------", row.children.first?.asRow?.children)
//        }
	}
	
	func onItemSelected(with event: SCDWidgetsItemEvent?) {
    	debugPrint("----onItemSelected", event?.item)
    	
//    	self.navigation?.push(page: ChildPageAdapter.pageName, transition: .forward)
    }
	
	deinit {
		bindables.forEach { $0.deactivate() }
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

@objcMembers
final class Timetable: EObject {
    dynamic var sessions: [Sessions]
    dynamic var rooms: [Rooms]
    dynamic var speakers: [Speakers]
    dynamic var questions: [Questions]
    dynamic var categories: [Categories]
    
    init(_ timetableResponse: TimetableResponse) {
    	self.sessions = timetableResponse.sessions
    	self.rooms = timetableResponse.rooms
    	self.speakers = timetableResponse.speakers
    	self.questions = timetableResponse.questions
    	self.categories = timetableResponse.categories
    }
}