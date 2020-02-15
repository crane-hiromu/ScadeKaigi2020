import ScadeKit

// MARK: - Extensions


extension SCDWidgetsImage {
    
    func load(with url: String) {
        DispatchQueue.global().async {
            let request = SCDNetworkRequest()
            request.url = url
            guard let response = request.call() else { return }
            
            DispatchQueue.main.async {
                self.content = dataToString(data: response.body, isUtf8: false)
                self.isContentPriority = true
            }
        }
    }
}
