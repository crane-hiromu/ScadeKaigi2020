import ScadeKit

// MARK: - Page

final class SponsorPageAdapter: SCDLatticePageAdapter {
    
    // MARK: Properties
    
    @objc dynamic private var sponsorEntity: SponsorEntity
    private var bindables = Set<SCDBindingBinding>()
    
    private lazy var sponsorPage: SponsorPage = {
        let view = SponsorPage(adapter: self)
        view.sponsorPageDelegate = self
        return view
    }()
    
    
    // MARK: Override
    
    init(sponsor: SponsorEntity) {
        debugPrint("---\(#function)---")
        
        self.sponsorEntity = sponsor
    }
    
    override func load(_ path: String) {		
        super.load(path)
        debugPrint("---\(#function)---")
        
        setupSafeArea()
        bind()
        observeCycle()
    }
    
    deinit {
        bindables.forEach { $0.deactivate() }
        cancelCycle()
    }
}


// MARK: - LifeCycleEventable

extension SponsorPageAdapter: LifeCycleEventable {
    
    func onEnter(with event: SCDWidgetsEnterEvent?) {
        AlertManager.shared.stopIndicator()
        bindables.forEach { $0.activate() }
    }
    
    func onExit(with event: SCDWidgetsExitEvent?) {
        bindables.forEach { $0.deactivate() }
    }
}


// MARK: - AboutPageDelegate

extension SponsorPageAdapter: SponsorPageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .timeTable, transition: .back)
    }
    
    func onItemSelected(with event: SCDWidgetsItemEvent?) {
        // todo open url
        print(event?.item)
    }
    
    func onSponsorClicked(by type: SponsorType) {
        navigation?.push(type: .web, data: type.url, transition: .forward)
    }
}


// MARK: - Private 

private extension SponsorPageAdapter {
    
    func bind() {    	
        debugPrint("---\(#function)---")
        
        /// loading a lot of images is crashed on Android by outOfMemory
        #if os(Android)
        bindTxt()
        #else
        bindImage()
        #endif    
        
        from(sponsorEntity)
            .select(\.sponsors)
            .bind(to: sponsorPage.goldDataSource)
            .registered(with: &bindables)
        
        from(sponsorEntity)
            .select(\.supporters)
            .bind(to: sponsorPage.supporterDataSource)
            .registered(with: &bindables)
    }
    
    func bindImage() {
        debugPrint("---\(#function)---")
        
        let bindableGoldItem = sponsorPage.bindableGoldItem
        let goldRow = sponsorPage.goldRow
        
        bindableGoldItem
            .select(\SponsorRowModel.left)
            .bind(to: goldRow.leftImage, mapFunction: { $0.logo })
            .registered(with: &bindables)
        
        bindableGoldItem
            .select(\SponsorRowModel.right)
            .bind(to: goldRow.rightImage, mapFunction: { $0.logo })
            .registered(with: &bindables)
        
        
        let bindableSupporterItem = sponsorPage.bindableSupporterItem
        let supporterRow = sponsorPage.supporterRow
        
        bindableSupporterItem
            .select(\SponsorRowModel.left)
            .bind(to: supporterRow.leftImage, mapFunction: { $0.logo })
            .registered(with: &bindables)
        
        bindableSupporterItem
            .select(\SponsorRowModel.right)
            .bind(to: supporterRow.rightImage, mapFunction: { $0.logo })
            .registered(with: &bindables)
    }
    
    func bindTxt() {
        debugPrint("---\(#function)---")
        
        let bindableGoldItem = sponsorPage.bindableGoldItem
        let goldRow = sponsorPage.goldRow
        
        bindableGoldItem
            .select(\SponsorRowModel.left)
            .bind(to: goldRow.leftText, mapFunction: { $0.name })
            .registered(with: &bindables)
        
        bindableGoldItem
            .select(\SponsorRowModel.right)
            .bind(to: goldRow.rightText, mapFunction: { $0.name })
            .registered(with: &bindables)
        
        bindableGoldItem
            .select(\SponsorRowModel.left)
            .bind(to: goldRow.leftColor, mapFunction: { $0.color })
            .registered(with: &bindables)
        
        bindableGoldItem
            .select(\SponsorRowModel.right)
            .bind(to: goldRow.rightColor, mapFunction: { $0.color })
            .registered(with: &bindables)
        
        
        let bindableSupporterItem = sponsorPage.bindableSupporterItem
        let supporterRow = sponsorPage.supporterRow
        
        bindableSupporterItem
            .select(\SponsorRowModel.left)
            .bind(to: supporterRow.leftText, mapFunction: { $0.name })
            .registered(with: &bindables)
        
        bindableSupporterItem
            .select(\SponsorRowModel.right)
            .bind(to: supporterRow.rightText, mapFunction: { $0.name })
            .registered(with: &bindables)
        
        bindableSupporterItem
            .select(\SponsorRowModel.left)
            .bind(to: supporterRow.leftColor, mapFunction: { $0.color })
            .registered(with: &bindables)
        
        bindableSupporterItem
            .select(\SponsorRowModel.right)
            .bind(to: supporterRow.rightColor, mapFunction: { $0.color })
            .registered(with: &bindables)
    }
}
