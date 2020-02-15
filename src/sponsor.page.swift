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
    }
}


// MARK: - AboutPageDelegate

extension SponsorPageAdapter: SponsorPageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .timeTable, transition: .back)
    }
    
    func onItemSelected(with event: SCDWidgetsItemEvent?) {
    		// todo open url
    }
}


// MARK: - Private 

private extension SponsorPageAdapter {
    
    func bind() {
    		debugPrint("---\(#function)---")
    		
        from(sponsorEntity)
            .select(\.sponsors)
            .bind(to: sponsorPage.dataSource)
            .registered(with: &bindables)
        
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
            .bind(to: goldRow.leftImage, mapFunction: { $0.logo })
            .registered(with: &bindables)

        supporterRow
            .select(\SponsorRowModel.right)
            .bind(to: goldRow.rightImage, mapFunction: { $0.logo })
            .registered(with: &bindables)
    }
}