import ScadeKit

// MARK: - Extension

extension SCDWidgetsWidget {
	
	/* Description
	
	 you can cast for target class
	 
	*/
	
	var asLabel: SCDWidgetsLabel? {
		return self as? SCDWidgetsLabel
	}
	
	var asList: SCDWidgetsListView? {
		return self as? SCDWidgetsListView
	}
	
	var asRow: SCDWidgetsRowView? {
		return self as? SCDWidgetsRowView
	}
	
	
	/* example
	 
	 let list: SCDWidgetsListView
	 let row = list.children.first?.cast(for: SCDWidgetsRowView.self)
	 
	*/
	func cast<T: SCDWidgetsWidget>(for: T.Type) -> T? {
		return self as? T
	}
}