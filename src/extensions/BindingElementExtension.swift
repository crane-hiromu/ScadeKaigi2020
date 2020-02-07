import ScadeKit

// MARK: - Extension

extension BindingElement where T == SCDWidgetsList {
	
	var rows: BindingElement<SCDWidgetsListElement> {
		return self.select(\.elements, .all)
	}
	
	var items: BindingElement<Any> {
		return self.select(\.items, .all)
	}
}

extension SCDBindingBinding {
	
    func registered(with bindables: inout Set<SCDBindingBinding>) {
    	bindables.insert(self)
    }
}