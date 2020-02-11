import ScadeKit

// MARK: - Delegate

protocol SpeakersListPageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
    func onItemSelected(with event: SCDWidgetsItemEvent?)
}

// MARK: - View

final class SpeakersListPage {
    
    // MARK: Properties
    
    weak var adapter: SpeakersListPageAdapter?
    weak var speakersListPageDelegate: SpeakersListPageDelegate?
    
    lazy var dataSource = from(speakerList).dataSource.cast([Speakers].self)
    lazy var bindableItem = from(speakerList).items
    lazy var row = from(speakerList).rows.cast(SpeakersListPageListElement.self)
    
    
    // MARK: Widgets
    
    private lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.speakersListPageDelegate?.onBackClicked()
        })
        return btn
    }()
    
    private lazy var speakerList: SCDWidgetsList! = {
        let list = adapter?.page?.getWidgetByName("speakerList")?.asList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
            self?.speakersListPageDelegate?.onItemSelected(with: event)
        })
        return list
    }()
    
    
    // MARK: Initializer
    
    init(adapter: SpeakersListPageAdapter?) {
        self.adapter = adapter
        
        /// todo access widgets
        backButton.isVisible = true
    }
    
    deinit {
        adapter = nil
        speakersListPageDelegate = nil
    }
}
