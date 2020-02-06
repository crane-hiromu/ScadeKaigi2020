import Foundation

// MARK: - API

final class HttpClient {
		
    static func call<T, V>(_ request: T, completion: @escaping (APIResult) -> Void)
        where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {
        	
            let task = URLSession.shared.dataTask(with: request.asURLRequest) { data, response, error in
                if let data = data {
                    completion(decodeData(request, data))
                } else {
                    completion(.failure(error ?? ResponseError(description: "")))
                }
            }
            task.resume()
    }

    private static func decodeData<T, V>(_ request: T, _ data: Data) -> APIResult
        where T: BaseRequestProtocol, V: Codable, T.ResponseType == V {

            if let result = try? JSONDecoder(type: .convertFromSnakeCase).decode(V.self, from: data) {
                return .success(result)
            } else {
                return .failure(DecodeError(description: String(data: data, encoding: .utf8)))
            }
    }
}

// MARK: - ResultType

enum APIResult {
    case success(Codable)
    case failure(Error)
}

// MARK: - Error

struct ResponseError: Error, CustomStringConvertible {
    let description: String
        
    init(description: String?) {
    	 self.description = "-- Response Error -- \(description ?? "none")"
    }
}

struct DecodeError: Error, CustomStringConvertible {
    let description: String
    
    init(description: String?) {
    	 self.description = "-- Decode Error -- \(description ?? "none")"
    }
}

// MARK: - JSONDecoder Extension

extension JSONDecoder {

    convenience init(type: JSONDecoder.KeyDecodingStrategy) {
        self.init()
        self.keyDecodingStrategy = type
    }

}

// MARK: - Options

typealias Headers = [String: String]
typealias Parameters = [String: Any]

struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    static let get = HTTPMethod(rawValue: "GET")
    static let post = HTTPMethod(rawValue: "POST")
//    static let connect = HTTPMethod(rawValue: "CONNECT")
//    static let delete = HTTPMethod(rawValue: "DELETE")
//    static let head = HTTPMethod(rawValue: "HEAD")
//    static let options = HTTPMethod(rawValue: "OPTIONS")
//    static let patch = HTTPMethod(rawValue: "PATCH")
//    static let put = HTTPMethod(rawValue: "PUT")
//    static let trace = HTTPMethod(rawValue: "TRACE")
    
    let rawValue: String

    init(rawValue: String) {
        self.rawValue = rawValue
    }
}
