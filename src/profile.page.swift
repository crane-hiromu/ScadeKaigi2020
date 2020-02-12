import ScadeKit

// MARK: - Adap

final class ProfilePageAdapter: SCDLatticePageAdapter {
    
    // MARK: Properties
    
    private var speakers: Speakers? = nil
    
    private lazy var profilePage: ProfilePage = {
        let view = ProfilePage(adapter: self)
        view.profilePageDelegate = self
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
        
        speakers = data as? Speakers
        setup()
    }
    
    deinit {
        cancelCycle()
        
    }
}


// MARK: - LifeCycleEventable

extension ProfilePageAdapter: LifeCycleEventable {
    
    func onEnter(with event: SCDWidgetsEnterEvent?) {
        
    }
    
    func onExit(with event: SCDWidgetsExitEvent?) {
        reset()
    }
}


// MARK: - ProfilePageDelegate

extension ProfilePageAdapter: ProfilePageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .speakersList, transition: .back)
    }
}


// MARK: - Private

private extension ProfilePageAdapter {
    
    func setup() {
        guard let profile = speakers else { return }
        
        profilePage.nameLabel.text = profile.fullName
        profilePage.tagLabel.text = profile.tagLine
        profilePage.bioLabel.text = profile.bio
        
        let session = DataManager.shared.sessions.first { $0.id == profile.sessions.first }
        profilePage.sessionLabel.text = session?.title.ja ?? ""
       	profilePage.timeLabel.text = "\(session?.startsAt.toDateAndTime ?? "") -"
        
        DispatchQueue.global().async {
            let request = SCDNetworkRequest()
            request.url = profile.profilePicture
            guard let response = request.call() else { return }
            
            self.profilePage.profileImage.content = dataToString(data: response.body, isUtf8: false)
            self.profilePage.profileImage.isContentPriority = true
        }
    }
    
    func reset() {
        profilePage.nameLabel.text = ""
        profilePage.tagLabel.text = ""
        profilePage.bioLabel.text = ""
        profilePage.profileImage.content = ""
        profilePage.profileImage.isContentPriority = false
    }
}
