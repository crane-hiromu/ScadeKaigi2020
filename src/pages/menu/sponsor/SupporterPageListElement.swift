import ScadeKit

// MARK: - Element

final class SupporterPageListElement: SCDWidgetsListElement {}


// MARK: - Extension

extension BindingElement where T == SupporterPageListElement {
    
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
    
    var leftText: BindingElement <String> {
        return parentWrapper.select(\.children, .at(0)).select(\SCDWidgetsButton.text)
    }
    
    var rightText: BindingElement <String> {
        return parentWrapper.select(\.children, .at(1)).select(\SCDWidgetsButton.text)
    }
    
    var leftColor: BindingElement <SCDGraphicsRGB> {
        return parentWrapper.select(\.children, .at(0)).select(\SCDWidgetsButton.backgroundColor)
    }
    
    var rightColor: BindingElement <SCDGraphicsRGB> {
        return parentWrapper.select(\.children, .at(1)).select(\SCDWidgetsButton.backgroundColor)
    }
}
