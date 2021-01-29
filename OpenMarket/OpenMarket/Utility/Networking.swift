import Foundation

struct Networking {
    static func fetchGoodsList(page: UInt, completion: @escaping (MarketGoods?, Error?) -> ()) {
        let api = FetchGoodsListAPI()
        let apiTaskLoader = APILoader(apiRequest: api)
        apiTaskLoader.loadAPIRequest(requestData: page) { (result, error) in
            completion(result, error)
        }
    }
    
    static func fetchGoods(id: UInt, completion: @escaping (Goods?, Error?) -> ()) {
        let api = FetchGoodsAPI()
        let apiTaskLoader = APILoader(apiRequest: api)
        apiTaskLoader.loadAPIRequest(requestData: 157) { (result, error) in
            completion(result, error)
        }
    }

    static func registerGoods(form: GoodsForm, completion: @escaping (Goods?, Error?) -> ()) {
        let api = RegisterGoodsAPI()
        let apiTaskLoader = APILoader(apiRequest: api)
        apiTaskLoader.loadAPIRequest(requestData: form) { (result, error) in
            completion(result, error)
        }
    }
    
    static func deleteGoods(form: GoodsForm, completion: @escaping (Goods?, Error?) -> ()) {
        let api = DeleteGoodsAPI()
        let apiTaskLoader = APILoader(apiRequest: api)
        apiTaskLoader.loadAPIRequest(requestData: <#T##UInt#>, completion: <#T##(Goods?, NetworkError?) -> ()#>)
    }
    
    static func editGoods(form: GoodsForm) {
        guard let id = form.id,
              let itemURL = NetworkConfig.makeURL(with: .editGoods(id: id)),
              let parameter = try? self.encodeData(form: form) else {
            return
        }

        requestToServer(with: itemURL, method: .post, parameter: parameter) { (result) in
            do {
                let data = try result.get()
                let json = try self.decodeData(to: MarketGoods.self, from: data)
                debugPrint(json)
            } catch let error {
                debugPrint(error)
            }
        }
    }
    
    static func removeGoods(form: GoodsForm) {
        guard let id = form.id,
              let itemURL = NetworkConfig.makeURL(with: .removeGoods(id: id)),
              let parameter = try? self.encodeData(form: form) else {
            return
        }
        
        requestToServer(with: itemURL, method: .delete, parameter: parameter) { (result) in
            do {
                let data = try result.get()
                debugPrint(data)
            } catch let error {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
