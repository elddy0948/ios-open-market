//
//  GoodsDetailItem.swift
//  OpenMarket
//
//  Created by Wonhee on 2021/01/26.
//

import Foundation

struct GoodsDetailItem: Decodable {
    let id: Int
    let title: String
    let price: Int
    let currency: String
    let stock: Int
    let thumbnails: [String]
    let images: [String]
    let descriptions: String
    let discountedPrice: Int?
    let registrationDate: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case currency
        case stock
        case thumbnails
        case images
        case descriptions
        case discountedPrice = "discounted_price"
        case registrationDate = "registration_date"
    }
}

protocol GoodsForm {
    var title: String? { get }
    var descriptions: String? { get }
    var price: Int? { get }
    var currency: String? { get }
    var stock: Int? { get }
    var discountedPrice: Int? { get }
    var images: [String]? { get }
    var password: String? { get }
    var convertParameter: [String : Any]? { get }
}
