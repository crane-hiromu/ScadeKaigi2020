import ScadeKit

// MARK: - Delegate

protocol WebPageDelegate: SCDLatticePageAdapter {
    func onBackClicked()
}


// MARK: - View

final class WebPage {
    
    // MARK: Properties
    
    weak var webPageDelegate: WebPageDelegate?
    private weak var adapter: WebPageAdapter?
    
    // MARK: Widgets
    
    lazy var backButton: SCDWidgetsButton! = {
        let btn = adapter?.page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.webPageDelegate?.onBackClicked()
        })
        return btn
    }()
    
    lazy var webView: SCDWidgetsWebView! = {
        let web = adapter?.page?.getWidgetByName("webView")?.asWebView
        return web
    }()
    
    
    // MARK: Initializer
    
    init(adapter: WebPageAdapter?) {
        self.adapter = adapter
        
        /// todo access
        backButton.isVisible = true
        
        webView.onLoaded.append(SCDWidgetsLoadEventHandler { event in 
        		print("Page Loaded: \(event)")
        })
				webView.onLoadFailed.append(SCDWidgetsLoadFailedEventHandler { event in 
						print("Page failed to load \(event)")
				})
   	}
    
    deinit {
        adapter = nil
        webPageDelegate = nil
    }
}