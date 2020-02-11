import ScadeKit

// MARK: - Delegate

protocol TimeTablePageDelegate: SCDLatticePageAdapter {
    func onItemSelected(with event: SCDWidgetsItemEvent?)
    func onTagSelected(with event: SCDWidgetsEvent?, at index: Int)
    func onTabClicked(by type: TimeTablePageType)
}

// MARK: - View

final class TimeTablePageView {
    
    // MARK: Properties
    
    var tabItems: [SCDWidgetsToolBarItem]
    var tabHandler: [SCDWidgetsEventHandler] = []
    weak var adapter: TimeTablePageAdapter?
    weak var timeTablePageDelegate: TimeTablePageDelegate?
    
    lazy var dataSource = from(timeTableList).dataSource.cast([Sessions].self)
    lazy var bindableItem = from(timeTableList).items
    lazy var row = from(timeTableList).rows.cast(TimeTablePageListElement.self)
    
    
    // MARK: Widgets
    
    private lazy var timeTableList: SCDWidgetsList! = {
        let list = adapter?.page?.getWidgetByName("timeTableList")?.asList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
            self?.timeTablePageDelegate?.onItemSelected(with: event)
        })
        return list
    }()
    
    
    // MARK: Initializer
    
    init(adapter: TimeTablePageAdapter?) {
        self.adapter = adapter
        self.tabItems = TimeTablePageType.allCases.compactMap { 
            adapter?.page?.getWidgetByName($0.tabItem)?.asToolBarItem
        }
        self.tabHandler = TimeTablePageType.allCases.compactMap { type in
            SCDWidgetsEventHandler{ [weak self] _ in
                self?.timeTablePageDelegate?.onTabClicked(by: type)
            }
        }
    }
    
    deinit {
        adapter = nil
    }
}


// MARK: - Internal

extension TimeTablePageView {
    
    func appendOnClick() {
        tabItems.enumerated().forEach { index, item in
            item.onClick.append(tabHandler[index])
        }
    }
    
    func removeOnClick() {
        tabItems.forEach { item in
            item.onClick.removeAll()
        }
    }
}
