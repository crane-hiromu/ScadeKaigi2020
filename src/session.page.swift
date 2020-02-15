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
        reset()
    }
    
    func onExit(with event: SCDWidgetsExitEvent?) {
        
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
        guard let sess = session else { return }
        
        sessionPage.sessionTitleLabel.text = sess.title.ja
        sessionPage.timeLabel.text = sess.startsAt.toTime
        sessionPage.minLabel.text = "\(sess.lengthInMinutes)min"
        sessionPage.roomLabel.text = DataManager.shared.room(by: sess.roomId) ?? ""
        sessionPage.categoryLabel.text = DataManager.shared.category(by: sess.sessionCategoryItemId)?.name.ja ?? ""
        sessionPage.langLabel.text = sess.language
        sessionPage.descriptionLabel.text = DataManager.shared.description(by: sess.id) ?? ""
        sessionPage.targetLabel.text = sess.targetAudience
        
        guard let speaker = DataManager.shared.speakers(by: sess.id).first else { return }
        sessionPage.speakerLabel.text = speaker.fullName
        sessionPage.speakerIconImage.load(with: speaker.profilePicture)
    }
    
    func reset() {
        sessionPage.sessionTitleLabel.text = ""
        sessionPage.timeLabel.text = ""
        sessionPage.minLabel.text = ""
        sessionPage.roomLabel.text = ""
        sessionPage.categoryLabel.text = ""
        sessionPage.langLabel.text = ""
        sessionPage.descriptionLabel.text = ""
        sessionPage.targetLabel.text = ""
        sessionPage.speakerLabel.text = ""
        sessionPage.speakerIconImage.content = ""
    }
}
