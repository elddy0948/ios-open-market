import Foundation

class APILoader<T: APIHandler> {
    let apiRequest: T
    let urlSession: URLSession
    
    init(apiRequest: T, urlSession: URLSession = .shared) {
        self.apiRequest = apiRequest
        self.urlSession = urlSession
    }
    
    func loadAPIRequest(requestData: T.RequestDataType, completion: @escaping (T.ResponseDataType?, NetworkError?) -> ()) {
        let urlRequest = apiRequest.makeRequest(from: requestData).urlRequest
        urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                return completion(nil, .data)
            }
            
            //parse response
            do {
                let parseResponse = try self.apiRequest.parseResponse(data: data)
                return completion(parseResponse, nil)
            } catch {
                return completion(nil, .response)
            }
        }.resume()
    }
}
