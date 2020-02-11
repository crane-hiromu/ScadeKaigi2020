import ScadeKit

// MARK: - Adapter

final class SpeckersListPageAdapter: SCDLatticePageAdapter {
	
		// MARK: Properties
	
		@objc dynamic private var model = SpeakersEntity()
		private var bindables = Set<SCDBindingBinding>()
			
		private lazy var backButton: SCDWidgetsButton! = {
        let btn = page?.getWidgetByName("backButton")?.asButton
        btn?.onClick.append(SCDWidgetsEventHandler { [weak self] event in
            self?.navigation?.push(page: "timeTable.page", transition: .back)
        })
        return btn
    }()
    
    private lazy var speakerList: SCDWidgetsList! = {
        let list = page?.getWidgetByName("speakerList")?.asList
        list?.onItemSelected.append(SCDWidgetsItemSelectedEventHandler { [weak self] event in
            
        })
        return list
    }()
		

		// MARK: Overrides
		
		override func load(_ path: String) {
        super.load(path)
        debugPrint("---\(#function)---")
        
        setupSafeArea()
        backButton.isVisible = true
        speakerList.isVisible = true
    }
		
		override func activate(_ view: SCDLatticeView?) {
        super.activate(view)
        debugPrint("---\(#function)---")
 
    }
    
    override func show(_ view: SCDLatticeView?, data: Any?) {
        super.show(view, data: data)
        debugPrint("---\(#function)---")
        
        guard let speakers = data as? [Speakers] else { return }
        model = SpeakersEntity(speakers)
        bind()
    }
    
    override func show(_ view: SCDLatticeView?) {
        super.show(view)
        debugPrint("---\(#function)---")
        
				observeCycle()
    }
		
		deinit {
				cancelCycle()
				bindables.forEach { $0.deactivate() }
		}
}


// MARK: - LifeCycleEventable

extension SpeckersListPageAdapter: LifeCycleEventable {
	
		func onEnter(with event: SCDWidgetsEnterEvent?) {
			
		}
		
		func onExit(with event: SCDWidgetsExitEvent?) {
				bindables.forEach { $0.deactivate() }
		}
}


// MARK: - Private

private extension SpeckersListPageAdapter {
	
		func bind() {
				let dataSource = from(speakerList).dataSource.cast([Speakers].self)
//			
				from(model)
						.select(\.speakers)
            .bind(to: dataSource)
            .registered(with: &bindables)
            
        let bindableItem = from(speakerList).items
    		let row = from(speakerList).rows.cast(SpeckersListPageListElement.self)
    		
    		bindableItem
            .select(\Speakers.fullName)
            .bind(to: row.fullName)
            .registered(with: &bindables)
		}
}