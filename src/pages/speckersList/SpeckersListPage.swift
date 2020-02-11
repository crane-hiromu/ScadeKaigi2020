import ScadeKit

// MARK: - Delegate

protocol SpeckersListPageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
    func onItemSelected(with event: SCDWidgetsItemEvent?)
}

// MARK: - View

final class SpeckersListPage {
    
    // MARK: Properties
    
    weak var adapter: SpeckersListPageAdapter?
    weak var speckersListPageDelegate: SpeckersListPageDelegate?
    
    lazy var dataSource = from(speakerList).dataSource.cast([Speakers].self)
    lazy var bindableItem = from(speakerList).items
    lazy var row = from(speakerList).rows.cast(SpeckersListPageListElement.self)
    
    
    // MARK: Widgets
    
    private lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.speckersListPageDelegate?.onBackClicked()
        })
        return btn
    }()
    
    private lazy var speakerList: SCDWidgetsList! = {
        let list = adapter?.page?.getWidgetByName("speakerList")?.asList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
            self?.speckersListPageDelegate?.onItemSelected(with: event)
        })
        return list
    }()
    
    
    // MARK: Initializer
    
    init(adapter: SpeckersListPageAdapter?) {
        self.adapter = adapter
        
        /// todo access widgets
        backButton.isVisible = true
    }
    
    deinit {
        adapter = nil
        speckersListPageDelegate = nil
    }
}
