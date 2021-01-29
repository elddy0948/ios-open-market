import Foundation

protocol Request {
    var urlRequest: URLRequest { get }
}

class BaseRequest: Request {
    private var request: URLRequest
    
    init(urlRequest: URLRequest) {
        self.request = urlRequest
    }
    
    var urlRequest: URLRequest {
        //header params
        self.request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
