import ScadeKit

// MARK: - Manager

final class AlertManager: EObject {
    
    static let shared = AlertManager()
    private override init() {}
    
    // MARK: loading indicator
    
    #if os(iOS)
    var indicator: UIAlertController = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.color = .orange
        indicator.center = CGPoint(x: 60, y: 30)
        indicator.startAnimating()
        
        let alert = UIAlertController(title: nil, message: "Loading..", preferredStyle: .alert)
        alert.view.addSubview(indicator)
        return alert
    }() 
    #endif
    
    func startIndicator() {
        #if os(iOS)
        DispatchQueue.main.async { 
            SCDApplication.rootViewController?.present(self.indicator, animated: true)
        }
        #endif
    }
    
    func stopIndicator(completion: @escaping () -> Void = {}) {	
        #if os(iOS)
        DispatchQueue.main.async {
            self.indicator.dismiss(animated: true, completion: completion)
        }		
        #endif
    }
    
    
    // MARK: not working
    
    #if os(iOS)
    var notWorking: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Coming Soon...", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        return alert
    }() 
    #endif
    
    func showNotWorking() {
    		#if os(iOS)
        DispatchQueue.main.async { 
            SCDApplication.rootViewController?.present(self.notWorking, animated: true)
        }
        #endif
    }
}
