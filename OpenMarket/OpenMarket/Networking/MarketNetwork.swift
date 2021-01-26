//
//  MarketNetwork.swift
//  OpenMarket
//
//  Created by Wonhee on 2021/01/26.
//

import Foundation

struct MarketNetwork {
    static func getGoodsList() {
        
    }
    
    static func registerGoods() {
        
    }
    
    static func searchGoods() {
        
    }
    
    static func editGoods() {
        
    }
    
    static func deleteGoods() {
        
    }
    
    func request(to methodType: NetworkMethodType, from url: URL,  with parameter: [String : Any]?, completion: @escaping ((Result<Data, NetworkError>) -> Void)) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = methodType.rawValue
        // TODO: add httpBody-parameter
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
        }
    }
}
