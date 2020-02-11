import ScadeKit

// MARK: - Element


final class SpeakersListPageListElement: SCDWidgetsListElement {}


// MARK: - Extension

extension BindingElement where T == SpeakersListPageListElement {
    
    // MARK: Wrapper
    
    private var parentWrapper: BindingElement<SCDWidgetsRowView> {
        return self.select(\.children, .at(0)).cast(SCDWidgetsRowView.self)
    }
    
    // MARK: Parts
    
    var fullName: BindingElement <String> {
        return parentWrapper.select(\.children, .at(1)).select(\SCDWidgetsLabel.text)
    }
    
}
