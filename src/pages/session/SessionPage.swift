import ScadeKit

// MARK: - Delegate

protocol SessionPageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
}

// MARK: - View

final class SessionPage {
	
	  // MARK: Properties
    
    weak var sessionPageDelegate: SessionPageDelegate?
    private weak var adapter: SessionPageAdapter?
    
    
    // MARK: Widgets
    
    lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.sessionPageDelegate?.onBackClicked()
        })
        return btn
    }()
    
		
		    
    // MARK: Initializer
    
    init(adapter: SessionPageAdapter?) {
        self.adapter = adapter
        
        /// todo access
        backButton.isVisible = true
    }
    
    deinit {
        adapter = nil
        sessionPageDelegate = nil
    }
}
