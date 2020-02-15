import ScadeKit

// MARK: - Application

final class ScadeKaigi2020: SCDApplication {
    
    // MARK: Properties
    
    private let window = SCDLatticeWindow()
    
    private lazy var timeTableAdapter: TimeTablePageAdapter = {
        let service: TimetableService? = SCDRuntime.loadService("TimetableService.service")
        guard let result = service?.getTimetable() else { fatalError() }
        DataManager.shared.set(timetable: result)
        
        let adapter = TimeTablePageAdapter(timetable: TimetableEntity(result),  pageType: .dayOne)
        return adapter
    }()
    
    private lazy var speakersListAdapter: SpeakersListPageAdapter = {
        let adapter = SpeakersListPageAdapter()
        return adapter
    }()
    
    private lazy var profileAdapter: ProfilePageAdapter = {
        let adapter = ProfilePageAdapter()
        return adapter
    }()
    
    private lazy var sessionAdapter: SessionPageAdapter = {
        let adapter = SessionPageAdapter()
        return adapter
    }()
     
    private lazy var aboutAdapter: AboutPageAdapter = {
        let adapter = AboutPageAdapter()
        return adapter
    }()
    
    private lazy var mapAdapter: MapPageAdapter = {
        let adapter = MapPageAdapter()
        return adapter
    }()

    private lazy var sponsorAdapter: SponsorPageAdapter = {
        let adapter = SponsorPageAdapter()
        return adapter
    }()
    
    
    // MARK: Overrides
    
    override func onFinishLaunching() {	
        debugPrint("---\(#function)---")
        
        DataManager.shared.call()
        
        timeTableAdapter.load(type: .timeTable)
        speakersListAdapter.load(type: .speakersList)
        profileAdapter.load(type: .profile)
        sessionAdapter.load(type: .session)
        aboutAdapter.load(type: .about)
        mapAdapter.load(type: .map)
        sponsorAdapter.load(type: .sponsor)
        
        timeTableAdapter.show(window)
    }
}


// MARK: - iOS

#if os(iOS) 

import UIKit 

extension SCDApplication {
    static var rootViewController: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
}
#endif
