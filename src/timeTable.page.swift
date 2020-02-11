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
        
        setupSafeArea()
        setup()
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
        bindAfter()
    }
    
    deinit {
        bindables.forEach { $0.deactivate() }
    }
}


// MARK: - Private 

private extension TimeTablePageAdapter {
    
    func setup() {
        // init first view
        timetable.update(type: pageType)
        
        // append tab btn event
        timeTablePageView.appendOnClick()
    }
    
    func bind() {	
        let dataSource = timeTablePageView.dataSource
        
        from(timetable)
            .select(\.sessions)
            .bind(to: dataSource)
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
    
    func bindAfter() {
        /// loading images should use a sub-thread
        /// not to block the main thread and not slow down view drawing
        //        DispatchQueue.global().async {
        //            self.timeTableList.elements.enumerated().forEach { i, wrapper in
        //            		let children = wrapper.children.first?.asRow?.children
        //                let icon = children?[1].asListView?.children[2].asRow?.children.first?.asImage
        //                let request = SCDNetworkRequest()
        //                request.url = icon?.content ?? ""
        //                if let response = request.call() {
        //                    icon?.content = String(data: response.body, encoding: .isoLatin1)! // todo
        //                    icon?.isContentPriority = true
        //                }
        //
        //            }
        //        }
        
        
        
        //        /// append tag click event
        //        DispatchQueue.global().async {
        //            self.timeTablePageView.timeTableList.elements.enumerated().forEach { i, wrapper in
        //                let image = wrapper.children.first?.asRow?.children[2].asImage
        //                image?.onClick.removeAll() // have to reset case of android keeping previous event
        //                image?.onClick.append(SCDWidgetsEventHandler { [weak self] e in
        //                    self?.onTagSelected(with: e, at: i)
        //                })
        //            }
        //        }
    }
}


// MARK: - TimeTablePageDelegate

extension TimeTablePageAdapter: TimeTablePageDelegate {
    
    func onItemSelected(with event: SCDWidgetsItemEvent?) {
        debugPrint("----onItemSelected", event?.item)
        
        //        self.navigation?.push(page: ChildPageAdapter.pageName, transition: .forward)
        
        //      let listElement = event!.element as? SCDWidgetsListElement
        //      listElement?.backgroundColor = SCDGraphicsRGB(red:10,green:10,blue:10)
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
        self.pageType = type
        timeTablePageView.removeOnClick()
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
                self.bind()
                self.bindAfter()
            }
        }
        #else
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            self.timetable.update(type: type)
            self.bindAfter()
        }
        #endif
        
        /// if click tab before finishing drawing view is crashed on App so wait for 2.5 second
        DispatchQueue.global().asyncAfter(deadline: .now()+2) {
            self.timeTablePageView.appendOnClick()
            AlertManager.shared.stopIndicator()
        }
    }
}
