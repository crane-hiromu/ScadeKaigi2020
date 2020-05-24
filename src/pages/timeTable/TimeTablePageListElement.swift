import ScadeKit

// MARK: - Element

final class TimeTablePageListElement: SCDWidgetsListElement {}


// MARK: - Extension

extension BindingElement where T == TimeTablePageListElement {
    
    // MARK: Wrapper
    
    private var parentWrapper: BindingElement<SCDWidgetsRowView> {
        return self.select(\.children, .at(0)).cast(SCDWidgetsRowView.self)
    }
    
    private var middleWrapper: BindingElement<SCDWidgetsRowView> {
        return parentWrapper.select(\.children, .at(1)).cast(SCDWidgetsRowView.self)
    }
    
    private var middleTopWrapper: BindingElement<SCDWidgetsRowView> {
        return middleWrapper.select(\.children, .at(0)).cast(SCDWidgetsRowView.self)
    }
    
    private var middleBottomWrapper: BindingElement<SCDWidgetsRowView> {
        return middleWrapper.select(\.children, .at(2)).cast(SCDWidgetsRowView.self)
    }
    
    // MARK: Parts
    
    var startTime: BindingElement<String> {
        return parentWrapper.select(\.children, .at(0)).select(\SCDWidgetsLabel.text)
    }
    
    var time: BindingElement<String> {
        return middleTopWrapper.select(\.children, .at(0)).select(\SCDWidgetsLabel.text)
    }
    
    var room: BindingElement<String> {
        return middleTopWrapper.select(\.children, .at(2)).select(\SCDWidgetsLabel.text)
    }
    
    var title: BindingElement<String> {
        return middleWrapper.select(\.children, .at(1)).select(\SCDWidgetsLabel.text)
    }
    
    var icon: BindingElement<String> {
        return middleBottomWrapper.select(\.children, .at(0)).select(\SCDWidgetsImage.content)
    }
    
    var iconVisible: BindingElement<Bool> {
        return middleBottomWrapper.select(\.children, .at(0)).select(\SCDWidgetsImage.isVisible)
    }
    
    var profileVisible: BindingElement<Bool> {
        return middleBottomWrapper.select(\SCDWidgetsContainer.layoutData).select(\SCDLayoutGridData.isExclude)
    }
    
    var name: BindingElement<String> {
        return middleBottomWrapper.select(\.children, .at(1)).select(\SCDWidgetsLabel.text)
    }
    
    var tagIcon: BindingElement<String> {
        return parentWrapper.select(\.children, .at(2)).select(\SCDWidgetsImage.url)
    }
}
