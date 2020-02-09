import ScadeKit

// MARK: - Extension

extension EObject {
	
	/* Description
	
	 you can cast for target class
	 
	*/
	
	var asLabel: SCDWidgetsLabel? {
		return self as? SCDWidgetsLabel
	}
	
	var asImage: SCDWidgetsImage? {
		return self as? SCDWidgetsImage
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