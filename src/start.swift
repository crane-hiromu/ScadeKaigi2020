import ScadeKit

// MARK: - Application

final class ScadeKaigi2020: SCDApplication {

	private let window = SCDLatticeWindow()
	
	private lazy var timeTableAdapter: TimeTablePageAdapter = {
			let service: TimetableService? = SCDRuntime.loadService("TimetableService.service")
      guard let result = service?.getTimetable() else { fatalError() } // todo
      
	    let adapter = TimeTablePageAdapter(
	    	timetable: TimetableEntity(result), 
	    	pageType: .dayOne
	    )
	    adapter.load("timeTable.page")
	    return adapter
	}()
	
	override func onFinishLaunching() {	
		timeTableAdapter.show(window)
	}
}