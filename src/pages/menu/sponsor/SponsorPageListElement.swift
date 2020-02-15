import ScadeKit

// MARK: - Element

final class SponsorPageListElement: SCDWidgetsListElement {}


// MARK: - Extension

extension BindingElement where T == SponsorPageListElement {
    
    // MARK: Wrapper
    
    private var parentWrapper: BindingElement<SCDWidgetsRowView> {
        return self.select(\.children, .at(0)).cast(SCDWidgetsRowView.self)
    }
    
        
    // MARK: Parts
    
    var leftImage: BindingElement <String> {
        return parentWrapper.select(\.children, .at(0)).select(\SCDWidgetsButton.backgroundImage)
    }
    
    var rightImage: BindingElement <String> {
        return parentWrapper.select(\.children, .at(1)).select(\SCDWidgetsButton.backgroundImage)
    }
}