import ScadeKit

// MARK: - Element


final class TimeTablePageListElement: SCDWidgetsListElement {
	
}

extension BindingElement where T == TimeTablePageListElement {
	
	// MARK: Wrapper
	
	var topWrapper: BindingElement<SCDWidgetsRowView> {
		return self.select(\.children, .at(0)).cast(SCDWidgetsRowView.self)
	}
	
	var middleWrapper: BindingElement<SCDWidgetsRowView> {
		return self.select(\.children, .at(1)).cast(SCDWidgetsRowView.self)
	}
		
	var bottomWrapper: BindingElement<SCDWidgetsRowView> {
		return self.select(\.children, .at(2)).cast(SCDWidgetsRowView.self)
	}
	
	// MARK: Parts
	
	var time: BindingElement <String> {
		return self.topWrapper.select(\.children, .at(0)).select(\SCDWidgetsLabel.text) // TODO
	}
	
	var title: BindingElement <String> {
		return self.middleWrapper.select(\.children, .at(0)).select(\SCDWidgetsLabel.text)
	}
	
	var name: BindingElement <String> {
		return self.bottomWrapper.select(\.children, .at(1)).select(\SCDWidgetsLabel.text) // TODO
	}
}