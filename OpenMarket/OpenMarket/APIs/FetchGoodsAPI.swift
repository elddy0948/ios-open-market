import Foundation

struct FetchGoodsAPI: APIHandler {
    func makeRequest(from data: UInt) -> Request {
        guard let url = NetworkConfig.makeURL(with: .fetchGoods(id: data)) else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let request = BaseRequest(urlRequest: urlRequest)
        return request
    }
    
    func parseResponse(data: Data) throws -> Goods {
        return try defaultParseResponse(to: Goods.self, from: data)
    }
}
