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
    
    
    // MARK: Overrides
    
    override func onFinishLaunching() {	
        debugPrint("---\(#function)---")
        
        timeTableAdapter.load(type: .timeTable)
        speakersListAdapter.load(type: .speakersList)
        profileAdapter.load(type: .profile)
        sessionAdapter.load(type: .session)
        
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
