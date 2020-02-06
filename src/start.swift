import ScadeKit

// MARK: - Application

final class ScadeKaigi2020: SCDApplication {

	private let window = SCDLatticeWindow()
	
	private lazy var timeTableAdapter: TimeTablePageAdapter = {
	    let adapter = TimeTablePageAdapter()
	    adapter.load("timeTable.page")
	    return adapter
	}()
	
	override func onFinishLaunching() {	
		timeTableAdapter.show(window)
	}
}