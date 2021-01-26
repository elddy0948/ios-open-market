//
//  MarketNetwork.swift
//  OpenMarket
//
//  Created by Wonhee on 2021/01/26.
//

import Foundation

// TODO: add handling error
struct MarketNetwork {
    static func searchGoodsList(with page: Int) {
        guard let url = NetworkConfig.makeURL(with: .searchGoodsList(page: page)) else {
            return
        }
        self.request(to: .get, from: url, with: nil) { result in
            do {
                let rawData = try result.get()
                let data = try self.convertData(to: GoodsList.self, from: rawData)
                debugPrint("🕵️‍♀️\(data)")
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func searchGoods(to id: Int) {
        guard let url = NetworkConfig.makeURL(with: .searchGoods(id: id)) else {
            return
        }
        self.request(to: .get, from: url, with: nil) { result in
            do {
                let rawData = try result.get()
                let data = try self.convertData(to: GoodsDetailItem.self, from: rawData)
                debugPrint("👋\(data)")
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func registerGoods(with form: GoodsForm) {
        guard let url = NetworkConfig.makeURL(with: .registerGoods) else {
            return
        }
        self.request(to: .post, from: url, with: form.convertParameter) { result in
            do {
                let rawData = try result.get()
                let data = try self.convertData(to: GoodsDetailItem.self, from: rawData)
                debugPrint("➕\(data)")
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        
    }
    
    static func editGoods(to id: Int, with form: GoodsForm) {
        guard let url = NetworkConfig.makeURL(with: .editGoods(id: id)) else {
            return
        }
        self.request(to: .patch, from: url, with: form.convertParameter) { result in
            do {
                let rawData = try result.get()
                let data = try self.convertData(to: GoodsDetailItem.self, from: rawData)
                debugPrint("📝\(data)")
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func deleteGoods(to id: Int) {
        guard let url = NetworkConfig.makeURL(with: .deleteGoods(id: id)) else {
            return
        }
        self.request(to: .delete, from: url, with: nil) { result in
            do {
                let rawData = try result.get()
                debugPrint("❌\(rawData)")
            } catch {
                debugPrint(error)
            }
        }
    }
}

extension MarketNetwork {
    private static func request(to methodType: NetworkMethodType, from url: URL,  with parameter: [String : Any]?, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = methodType.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let params = parameter {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(.network))
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(.network))
            }
            guard let data = data else {
                return completion(.failure(.getData))
            }
            return completion(.success(data))
        }.resume()
    }
    
    private static func convertData<T: Decodable>(to type: T.Type, from data: Data) throws -> T {
        let data = try JSONDecoder().decode(type, from: data)
        return data
    }
}
