import ScadeKit

// MARK: - Delegate

protocol SponsorPageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
    func onItemSelected(with event: SCDWidgetsItemEvent?)
}


// MARK: - View

final class SponsorPage {
	    
    // MARK: Properties
    
    weak var sponsorPageDelegate: SponsorPageDelegate?
    private weak var adapter: SponsorPageAdapter?
    
    lazy var goldDataSource = from(goldList).dataSource.cast([SponsorRowModel].self)
    lazy var bindableGoldItem = from(goldList).items
    lazy var goldRow = from(goldList).rows.cast(SponsorPageListElement.self)
    
    lazy var supporterDataSource = from(supporterList).dataSource.cast([SponsorRowModel].self)
    lazy var bindableSupporterItem = from(supporterList).items
    lazy var supporterRow = from(supporterList).rows.cast(SupporterPageListElement.self)
    
    // MARK: Widgets
    
    lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.sponsorPageDelegate?.onBackClicked()
        })
        return btn
    }()
    
    private lazy var goldList: SCDWidgetsList! = {
        let list = adapter?.page?.getWidgetByName("goldList")?.asList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
            self?.sponsorPageDelegate?.onItemSelected(with: event)
        })
        return list
    }()
    
    private lazy var supporterList: SCDWidgetsList! = {
        let list = adapter?.page?.getWidgetByName("supporterList")?.asList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
            self?.sponsorPageDelegate?.onItemSelected(with: event)
        })
        return list
    }()
    
    // MARK: Initializer
    
    init(adapter: SponsorPageAdapter?) {
        self.adapter = adapter
        
        /// todo access
        backButton.isVisible = true
    }
    
    deinit {
        adapter = nil
        sponsorPageDelegate = nil
    }
}