import ScadeKit

// MARK: - Element


final class SpeckersListPageListElement: SCDWidgetsListElement {}


// MARK: - Extension

extension BindingElement where T == SpeckersListPageListElement {
	
    // MARK: Wrapper
    
    private var parentWrapper: BindingElement<SCDWidgetsRowView> {
        return self.select(\.children, .at(0)).cast(SCDWidgetsRowView.self)
    }
			    
    // MARK: Parts
    
    var fullName: BindingElement <String> {
        return parentWrapper.select(\.children, .at(1)).select(\SCDWidgetsLabel.text)
    }
   
}