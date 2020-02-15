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
    
    lazy var sessionTitleLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("sessionTitle")?.asLabel
    }()
    
    lazy var timeLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("timeLabel")?.asLabel
    }()
    
    lazy var minLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("minLabel")?.asLabel
    }()
    
    lazy var roomLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("roomLabel")?.asLabel
    }()
    
    lazy var categoryLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("categoryLabel")?.asLabel
    }()
    
    lazy var langLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("langLabel")?.asLabel
    }()
    
    lazy var descriptionLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("descriptionLabel")?.asLabel
    }()
    
    lazy var targetLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("targetLabel")?.asLabel
    }()   
    
    lazy var speakerIconImage: SCDWidgetsImage! = {
        return adapter?.page?.getWidgetByName("speakerIconImage")?.asImage
    }()
    
    lazy var speakerLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("speakerLabel")?.asLabel
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
