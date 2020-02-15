import ScadeKit

// MARK: - Page

final class MapPageAdapter: SCDLatticePageAdapter {

    // MARK: Properties
    
    private lazy var mapPage: MapPage = {
        let view = MapPage(adapter: self)
        view.mapPageDelegate = self
        return view
    }()
    
    
    // MARK: Overrides
    
    override func load(_ path: String) {		
        super.load(path)
        debugPrint("---\(#function)---")
        
        setupSafeArea()
        
        // accsess
        mapPage.backButton.isVisible = true
    }
}


// MARK: - MapPageDelegate

extension MapPageAdapter: MapPageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .timeTable, transition: .back)
    }
}
