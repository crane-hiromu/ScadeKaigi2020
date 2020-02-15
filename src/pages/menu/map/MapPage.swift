import ScadeKit

// MARK: - Delegate

protocol MapPageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
}


// MARK: - View

final class MapPage {
    
    // MARK: Properties
    
    weak var mapPageDelegate: MapPageDelegate?
    private weak var adapter: MapPageAdapter?
    
    // MARK: Widgets
    
    lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.mapPageDelegate?.onBackClicked()
        })
        return btn
    }()
    
    
    // MARK: Initializer
    
    init(adapter: MapPageAdapter?) {
        self.adapter = adapter
        
        /// todo access
        backButton.isVisible = true
    }
    
    deinit {
        adapter = nil
        mapPageDelegate = nil
    }
}