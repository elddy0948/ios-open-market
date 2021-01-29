import Foundation

struct RegisterGoodsAPI: APIHandler {
    func makeRequest(from data: GoodsForm) -> Request {
        guard let url = NetworkConfig.makeURL(with: .registerGoods) else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        set(data, urlRequest: &urlRequest)
        
        let request = BaseRequest(urlRequest: urlRequest)
        return request
    }
    
    func parseResponse(data: Data) throws -> Goods {
        return try defaultParseResponse(to: Goods.self, from: data)
    }
}
