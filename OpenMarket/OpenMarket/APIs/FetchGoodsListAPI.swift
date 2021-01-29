import Foundation

struct FetchGoodsListAPI: APIHandler {
    func makeRequest(from data: UInt) -> Request {
        guard let url = NetworkConfig.makeURL(with: .fetchGoodsList(page: data)) else {
            fatalError()
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let request = BaseRequest(urlRequest: urlRequest)
        return request
    }
    
    func parseResponse(data: Data) throws -> MarketGoods {
        return try defaultParseResponse(to: MarketGoods.self, from: data)
    }
}
