import Foundation

struct DeleteGoodsAPI: APIHandler {
    func makeRequest(from data: GoodsForm) -> Request {
        guard let url = NetworkConfig.makeURL(with: .removeGoods(id: data)) else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        let request = BaseRequest(urlRequest: urlRequest)
        return request
    }
    
    func parseResponse(data: Data) throws -> Goods {
        return try defaultParseResponse(to: Goods.self, from: data)
    }
}
