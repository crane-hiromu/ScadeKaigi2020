import ScadeKit

// MARK: - Application

final class ScadeKaigi2020: SCDApplication {
	
		// MARK: Properties
    
    private let window = SCDLatticeWindow()
    
    private lazy var timeTableAdapter: TimeTablePageAdapter = {
        let service: TimetableService? = SCDRuntime.loadService("TimetableService.service")
        guard let result = service?.getTimetable() else { fatalError() } // todo
        
        let adapter = TimeTablePageAdapter(
            timetable: TimetableEntity(result), 
            pageType: .dayOne
        )
        return adapter
    }()
    
    private lazy var speckersListAdapter: SpeckersListPageAdapter = {
        let adapter = SpeckersListPageAdapter()
        return adapter
    }()
    
    
    // MARK: Overrides
    
    override func onFinishLaunching() {	
        debugPrint("---\(#function)---")
        
        timeTableAdapter.load("timeTable.page")
        speckersListAdapter.load("speckersList.page")
        
        
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