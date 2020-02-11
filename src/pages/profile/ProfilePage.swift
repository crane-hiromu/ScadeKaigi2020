import ScadeKit

// MARK: - Delegate

protocol ProfilePageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
}

// MARK: - View

final class ProfilePage {
    
    // MARK: Properties
    
    weak var profilePageDelegate: ProfilePageDelegate?
    private weak var adapter: ProfilePageAdapter?
    
    // MARK: Widgets
    
    lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.profilePageDelegate?.onBackClicked()
        })
        return btn
    }()
    
    lazy var profileImage: SCDWidgetsImage! = {
        return adapter?.page?.getWidgetByName("profileImage")?.asImage
    }()
    
    lazy var nameLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("nameLabel")?.asLabel
    }()
    
    lazy var tagLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("tagLabel")?.asLabel
    }()
    
    lazy var bioLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("bioLabel")?.asLabel
    }()
    
    lazy var sessionLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("sessionLabel")?.asLabel
    }()
    
    lazy var timeLabel: SCDWidgetsLabel! = {
        return adapter?.page?.getWidgetByName("timeLabel")?.asLabel
    }()
    
    
    // MARK: Initializer
    
    init(adapter: ProfilePageAdapter?) {
        self.adapter = adapter
        
        /// todo access
        backButton.isVisible = true
    }
    
    deinit {
        adapter = nil
        profilePageDelegate = nil
    }
}
