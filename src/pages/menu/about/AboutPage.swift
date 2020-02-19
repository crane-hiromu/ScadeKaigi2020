import ScadeKit

// MARK: - Delegate

protocol AboutPageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
}


// MARK: - View

final class AboutPage {
    
    // MARK: Properties
    
    weak var aboutPageDelegate: AboutPageDelegate?
    private weak var adapter: AboutPageAdapter?
    
    // MARK: Widgets
    
    lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.aboutPageDelegate?.onBackClicked()
        })
        return btn
    }()
    
    lazy var descLabel: SCDWidgetsLabel! = {
        let label = adapter?.page?.getWidgetByName("descLabel")?.asLabel
        return label
    }()
    
    
    // MARK: Initializer
    
    init(adapter: AboutPageAdapter?) {
        self.adapter = adapter
        
        /// todo access
        backButton.isVisible = true
    }
    
    deinit {
        adapter = nil
        aboutPageDelegate = nil
    }
}
