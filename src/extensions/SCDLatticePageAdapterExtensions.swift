import ScadeKit
import Foundation

// MARK: - Adapter Extension

extension SCDLatticePageAdapter {
    
    func setupSafeArea() {
        // todo name
        
        let content = self.page?.getWidgetByName("statusBarContent")?.asRow?.layoutData?.asGridData
        let notch = self.page?.getWidgetByName("statusBarNotch")?.asRow?.layoutData?.asGridData
        
        #if(os(Android))	
        content?.isExclude = true
        notch?.isExclude = true
        #elseif(os(iOS))
        content?.isExclude = false
        notch?.isExclude = !Constants.hasNotch
        #endif
    }
    
    func load(type: Constants.PageType) {
    		load(type.page)
    }
}
