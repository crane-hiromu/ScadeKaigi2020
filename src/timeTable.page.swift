import ScadeKit

// MARK: - Adapter

final class TimeTablePageAdapter: SCDLatticePageAdapter {
    
    // MARK: Properties
    
    @objc dynamic private var timetable: TimetableEntity
    private var pageType: TimeTablePageType
    private var bindables = Set<SCDBindingBinding>()
    
    private lazy var timeTablePageView: TimeTablePageView = {
        let view = TimeTablePageView(adapter: self)
        view.timeTablePageDelegate = self
        return view
    }()
    
    
    // MARK: Override
    
    init(timetable: TimetableEntity, pageType: TimeTablePageType) {
        debugPrint("---\(#function)---")
        
        self.timetable = timetable
        self.pageType = pageType
    }
    
    override func load(_ path: String) {
        super.load(path)
        debugPrint("---\(#function)---")
        
        timetable.update(type: pageType) // init first view
        setupSafeArea()
        bind()
    }
    
    override func activate(_ view: SCDLatticeView?) {
        super.activate(view)
        debugPrint("---\(#function)---")
    }
    
    override func show(_ view: SCDLatticeView?, data: Any?) {
        super.show(view, data: data)
        debugPrint("---\(#function)---")
    }
    
    override func show(_ view: SCDLatticeView?) {
        super.show(view)
        debugPrint("---\(#function)---")
        
        setup()
    }
    
    deinit {
        bindables.forEach { $0.deactivate() }
        cancelCycle()
    }
}


// MARK: - LifeCycleEventable

extension TimeTablePageAdapter: LifeCycleEventable {
	
		func onEnter(with event: SCDWidgetsEnterEvent?) {
				bindables.forEach { $0.activate() }
		}
		
		func onExit(with event: SCDWidgetsExitEvent?) {
				bindables.forEach { $0.deactivate() }
		}
}


// MARK: - Private 

private extension TimeTablePageAdapter {
    
    func bind() {
        from(timetable)
            .select(\.sessions)
            .bind(to: timeTablePageView.dataSource)
            .registered(with: &bindables)
        
        let bindableItem = timeTablePageView.bindableItem
        let row = timeTablePageView.row
        
        bindableItem
            .select(\Sessions.startsAt)
            .bind(to: row.startTime, mapFunction: { $0.toTime })
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.lengthInMinutes)
            .bind(to: row.time, mapFunction: { "\($0)分" })
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.roomId)
            .bind(to: row.room, mapFunction: { [weak self] id in
                self?.timetable.room(by: id) ?? ""
            })
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.title.ja)
            .bind(to: row.title)
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.id)
            .bind(to: row.name, mapFunction: { [weak self] id in
                self?.timetable.speakers(by: id).first?.fullName ?? ""
            })
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.id)
            .bind(to: row.icon, mapFunction: { [weak self] id in
                self?.timetable.speakers(by: id).first?.profilePicture ?? ""
            })
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.id)
            .bind(to: row.iconVisible, mapFunction: { [weak self] id in
                (self?.timetable.speakers(by: id).first?.profilePicture != nil)
            })
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.id)
            .bind(to: row.profileVisible, mapFunction: { [weak self] id in
                (self?.timetable.speakers(by: id).first?.profilePicture == nil)
            })
            .registered(with: &bindables)
        
        bindableItem
            .select(\Sessions.id)
            .bind(to: row.tagIcon, mapFunction: { Constants.Tag.icon(by: $0) })
            .registered(with: &bindables)
    }
    
    func setup() {
    	  timeTablePageView.appendOnTabClick()
        timeTablePageView.appendOnTagClick()
        observeCycle()
    }
    
//    func bindAfter() {
//        /// loading images should use a sub-thread
//        /// not to block the main thread and not slow down view drawing
//        //        DispatchQueue.global().async {
//        //            self.timeTableList.elements.enumerated().forEach { i, wrapper in
//        //            		let children = wrapper.children.first?.asRow?.children
//        //                let icon = children?[1].asListView?.children[2].asRow?.children.first?.asImage
//        //                let request = SCDNetworkRequest()
//        //                request.url = icon?.content ?? ""
//        //                if let response = request.call() {
//        //                    icon?.content = String(data: response.body, encoding: .isoLatin1)! // todo
//        //                    icon?.isContentPriority = true
//        //                }
//        //
//        //            }
//        //        }
//        
//        
//        /// append tag click event
//				timeTablePageView.appendOnTagClick()
//    }
}


// MARK: - TimeTablePageDelegate

extension TimeTablePageAdapter: TimeTablePageDelegate {
	
	  func onSearchClicked() {
    		debugPrint("---\(#function)---")
    		
    		navigation?.push(type: .speakersList, data: timetable.speakers, transition: .forward)
    }
    
    func onMenuClicked() {
    		debugPrint("---\(#function)---")
    		
    		timeTablePageView.setSidebar()
    }
    
    func onItemSelected(with event: SCDWidgetsItemEvent?) {
        debugPrint("----onItemSelected")
        
        navigation?.push(type: .session, data: event?.item, transition: .forward)
    }
    
    func onTagSelected(with event: SCDWidgetsEvent?, at index: Int) {
        debugPrint("---\(#function)---")
        
        let id = timetable.sessions[index].id
        var ids: [String] = UserDefaultsHelper.sessionIds.arrayString ?? []
        
        if let idIndex = ids.firstIndex(of: id) {
            ids.remove(at: idIndex)
        } else {
            ids.append(id)
        }
        UserDefaultsHelper.sessionIds.setItem(with: ids)
        event?.target?.asImage?.url = Constants.Tag.icon(by: id)
    }
    
    func onTabClicked(by type: TimeTablePageType) {
    		debugPrint("---\(#function)---")
    		
    		guard self.pageType != type else { return } // ignore click current tab
    		
        self.pageType = type
        timeTablePageView.removeOnTabClick()
        timeTablePageView.tabItems.enumerated().forEach { i, item in
            item.backgroundColor = (type.rawValue == i) ? .tabItemOrange : .white
        }
        AlertManager.shared.startIndicator()
        
        /// refreshing list by binding is crashed on Android so reset bind for Android only
        #if os(Android)
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.bindables.forEach { $0.deactivate() }
            self.timetable.update(type: type)
            
            DispatchQueue.main.async {
                self.bindables.forEach { $0.activate() }
                self.timeTablePageView.appendOnTagClick()
            }
        }
        #else
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.timetable.update(type: type)
            self.timeTablePageView.appendOnTagClick()
        }
        #endif
        
        /// if click tab before finishing drawing view is crashed on App so wait for 2.5 second
        DispatchQueue.global().asyncAfter(deadline: .now()+2.5) {
            self.timeTablePageView.appendOnTabClick()
            AlertManager.shared.stopIndicator()
        }
    }
}