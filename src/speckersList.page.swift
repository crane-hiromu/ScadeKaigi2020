import ScadeKit


// MARK: - Adapter

final class SpeckersListPageAdapter: SCDLatticePageAdapter {
    
    // MARK: Properties
    
    @objc dynamic private var model = SpeakersEntity()
    private var bindables = Set<SCDBindingBinding>()
    
    private lazy var speckersListPage: SpeckersListPage = {
        let view = SpeckersListPage(adapter: self)
        view.speckersListPageDelegate = self
        return view
    }()
    
    
    // MARK: Overrides
    
    override func load(_ path: String) {
        super.load(path)
        debugPrint("---\(#function)---")
        
        setupSafeArea()
        observeCycle()
        bind()
    }
    
    override func show(_ view: SCDLatticeView?, data: Any?) {
        super.show(view, data: data)
        debugPrint("---\(#function)---")
        
        guard let speakers = data as? [Speakers] else { return }
        model.update(speakers: speakers)         
    }
    
    deinit {
        cancelCycle()
        bindables.forEach { $0.deactivate() }
    }
}


// MARK: - LifeCycleEventable

extension SpeckersListPageAdapter: LifeCycleEventable {
    
    func onEnter(with event: SCDWidgetsEnterEvent?) {
        bindables.forEach { $0.activate() }
    }
    
    func onExit(with event: SCDWidgetsExitEvent?) {
        bindables.forEach { $0.deactivate() }
    }
}


// MARK: - Private

private extension SpeckersListPageAdapter {
    
    func bind() {
        from(model)
            .select(\.speakers)
            .bind(to: speckersListPage.dataSource)
            .registered(with: &bindables)
        
        let bindableItem = speckersListPage.bindableItem
        let row = speckersListPage.row
        
        bindableItem
            .select(\Speakers.fullName)
            .bind(to: row.fullName)
            .registered(with: &bindables)
    }
}


// MARK: - SpeckersListPageAdapter

extension SpeckersListPageAdapter: SpeckersListPageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .timeTable, transition: .back)
    }
    
    func onItemSelected(with event: SCDWidgetsItemEvent?) {
        
    }
}
