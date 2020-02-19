import ScadeKit

// MARK: - Page

final class WebPageAdapter: SCDLatticePageAdapter {
    
    // MARK: Properties
    
    private lazy var webPage: WebPage = {
        let view = WebPage(adapter: self)
        view.webPageDelegate = self
        return view
    }()
    
    
    // MARK: Overrides
    
    override func load(_ path: String) {		
        super.load(path)
        debugPrint("---\(#function)---")
        
        setupSafeArea()
        observeCycle()
    }
    
    override func show(_ view: SCDLatticeView?, data: Any?) {
        super.show(view, data: data)
        debugPrint("---\(#function)---")
        
        guard let url = data as? String else { return }
        webPage.webView.load(url)
    }
    
    deinit {
        cancelCycle()
    }
}


// MARK: - LifeCycleEventable

extension WebPageAdapter: LifeCycleEventable {
    
    func onEnter(with event: SCDWidgetsEnterEvent?) {
        
    }
    
    func onExit(with event: SCDWidgetsExitEvent?) {
        webPage.webView.load("")
    }
}


// MARK: - MapPageDelegate

extension WebPageAdapter: WebPageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .sponsor, transition: .back)
    }
}
