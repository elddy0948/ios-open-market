//
//  GoodsItem.swift
//  OpenMarket
//
//  Created by Wonhee on 2021/01/26.
//

import Foundation

struct GoodsItem: Decodable {
    let id: Int
    let title: String
    let price: Int
    let currency: String
    let stock: Int
    let thumbnails: [String]
    let descriptions: String?
    let discountedPrice: Int?
    let registrationDate: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case currency
        case stock
        case thumbnails
        case descriptions
        case discountedPrice = "discounted_price"
        case registrationDate = "registration_date"
    }
}
