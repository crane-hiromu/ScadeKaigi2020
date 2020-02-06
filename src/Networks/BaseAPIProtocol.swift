import Foundation
import ScadeKit

// MARK: - BaseAPIProtocol

protocol BaseAPIProtocol {
    associatedtype ResponseType

    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers: Headers? { get }
}

extension BaseAPIProtocol {
    var baseURL: URL {
    	return URL(string: Constants.API.baseURL)!
    }
    var headers: Headers? {
        return [
            "Content-Type": "application/json; charset=utf-8",
            "User-Agent": "official-app-2020/1.0 gzip"
        ]
    }
}

// MARK: - BaseRequestProtocol

protocol BaseRequestProtocol: BaseAPIProtocol {
    var parameters: Parameters? { get }
    var asURLRequest: URLRequest { get }
}

extension BaseRequestProtocol {

    var asURLRequest: URLRequest {
        var urlRequest: URLRequest = {
            let url = baseURL.appendingPathComponent(path)
        	guard let params = parameters else { return URLRequest(url: url) }                           

            // todo post
			
            // get
            var compnents = URLComponents(string: url.absoluteString)
            compnents?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
            return URLRequest(url: compnents!.url!)
        }()
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = TimeInterval(30)
        return urlRequest
    }

}
