import ScadeKit

// MARK: - Adapter

final class SessionPageAdapter: SCDLatticePageAdapter {
	
    // MARK: Properties
    
    private var session: Sessions? = nil
    
    private lazy var sessionPage: SessionPage = {
        let view = SessionPage(adapter: self)
        view.sessionPageDelegate = self
        return view
    }()
    

		// MARK: Override
	
		override func load(_ path: String) {		
				super.load(path)
				debugPrint("---\(#function)---")
				
				setupSafeArea()
        observeCycle()
		}
		
		override func show(_ view: SCDLatticeView?, data: Any?) {
        super.show(view, data: data)
        debugPrint("---\(#function)---")
        
        session = data as? Sessions
        setup()
    }
    
    deinit {
        cancelCycle()
    }
}


// MARK: - LifeCycleEventable

extension SessionPageAdapter: LifeCycleEventable {
    
    func onEnter(with event: SCDWidgetsEnterEvent?) {
        
    }
    
    func onExit(with event: SCDWidgetsExitEvent?) {
        reset()
    }
}


// MARK: - SessionPageDelegate

extension SessionPageAdapter: SessionPageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .timeTable, transition: .back)
    }
}


// MARK: - Private

private extension SessionPageAdapter {
	
		func setup() {
				//todo
				sessionPage.backButton.isVisible = true // access
		}
		
		func reset() {
			
		}
}