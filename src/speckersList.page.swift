import ScadeKit

// MARK: - Adapter

final class SpeckersListPageAdapter: SCDLatticePageAdapter {
	
		// MARK: Properties
	
		@objc dynamic private var model = SpeakersEntity()
			
		private lazy var menuButton: SCDWidgetsButton! = {
        let btn = page?.getWidgetByName("closeButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.navigation?.go("timeTable.page")
        })
        return btn
    }()
    
    private lazy var timeTableList: SCDWidgetsList! = {
        let list = page?.getWidgetByName("speakerList")?.asList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
            
        })
        return list
    }()
		

		// MARK: Overrides
		
		override func activate(_ view: SCDLatticeView?) {
        super.activate(view)
        debugPrint("---\(#function)---")
        
        HttpClient.call(SpeakersRequest()) { [weak self] result in
        		switch result {
        		case let .success(response):
        				self?.model.speakers = (response as? [Speaker]) ?? []

        		case let .failure(error):
        				self?.model.speakers = []
        		}
        }
        
        menuButton.isVisible = true
        timeTableList.isVisible = true
    }
    
    override func show(_ view: SCDLatticeView?, data: Any?) {
        super.show(view, data: data)
        debugPrint("---\(#function)---")
    }
    
    override func show(_ view: SCDLatticeView?) {
        super.show(view)
        debugPrint("---\(#function)---")
        
				observeCycle()
    }
		
		deinit {
				cancelCycle()
		}
}


// MARK: - LifeCycleEventable

extension SpeckersListPageAdapter: LifeCycleEventable {
	
		func onEnter(with event: SCDWidgetsEnterEvent?) {
			
		}
		
		func onExit(with event: SCDWidgetsExitEvent?) {
			
		}
}