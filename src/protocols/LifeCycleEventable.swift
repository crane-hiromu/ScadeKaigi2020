import ScadeKit

// MARK: - Protocol

protocol LifeCycleEventable: EObject {
		func observeCycle()
		func cancelCycle()
		func onEnter(with event: SCDWidgetsEnterEvent?)
		func onExit(with event: SCDWidgetsExitEvent?)
}

extension LifeCycleEventable where Self: SCDLatticePageAdapter {
	
		func observeCycle() {
				page?.onEnter.append(SCDWidgetsEnterEventHandler { [weak self] event in
        		debugPrint("---onEnter---", self?.className ?? "")
        		self?.onEnter(with: event)
        })
        page?.onExit.append(SCDWidgetsExitEventHandler { [weak self] event in
        		debugPrint("---onExit---", self?.className ?? "")
        		self?.onExit(with: event)
        })
		}
		
		func cancelCycle() {
				page?.onEnter.removeAll()
				page?.onExit.removeAll()
		}
}