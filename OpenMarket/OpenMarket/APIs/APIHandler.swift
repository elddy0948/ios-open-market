import Foundation

protocol RequestHandler {
    associatedtype RequestDataType
    func makeRequest(from data: RequestDataType) -> Request
}

protocol ResponseHandler {
    associatedtype ResponseDataType
    func parseResponse(data: Data) throws -> ResponseDataType
}

extension RequestHandler {
    func set<T: Encodable>(_ parameters: T, urlRequest: inout URLRequest) {
        //http body
        let data = try? JSONEncoder().encode(parameters)
        urlRequest.httpBody = data
    }
}

extension ResponseHandler {
    func defaultParseResponse<T: Decodable>(to type: T.Type, from data: Data) throws -> T {
        let data = try JSONDecoder().decode(T.self, from: data)
        return data
    }
}

typealias APIHandler = RequestHandler & ResponseHandler
