import ScadeKit

// MARK: - Page

final class AboutPageAdapter: SCDLatticePageAdapter {

    // MARK: Properties
    
    private lazy var aboutPage: AboutPage = {
        let view = AboutPage(adapter: self)
        view.aboutPageDelegate = self
        return view
    }()
    
    
    // MARK: Overrides
    
    override func load(_ path: String) {		
        super.load(path)
        debugPrint("---\(#function)---")
        
        setupSafeArea()
        aboutPage.descLabel.text = "DroidKaigiはエンジニアが主役のAndroidカンファレンスです。Android技術情報の共有とコミュニケーションを目的に、2020年2月20日(木)、21日(金)の2日間開催します。"
    }
}


// MARK: - AboutPageDelegate

extension AboutPageAdapter: AboutPageDelegate {
    
    func onBackClicked() {
        navigation?.push(type: .timeTable, transition: .back)
    }
}
