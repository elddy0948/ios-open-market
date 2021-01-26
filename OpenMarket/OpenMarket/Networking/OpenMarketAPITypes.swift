//
//  OpenMarketAPITypes.swift
//  OpenMarket
//
//  Created by Wonhee on 2021/01/26.
//

import Foundation

enum OpenMarketAPITypes{
    case getGoodsList(page: Int)
    case registerGoods
    case getGoods(id: Int)
    case editGoods(id: Int)
    case deleteGoods(id: Int)
    
    var urlQuery: String {
        switch self {
        case .getGoodsList(page: let page):
            return "/items/\(page)"
        case .registerGoods:
            return "/item"
        case .getGoods(id: let id):
            return "/item/\(id)"
        case .editGoods(id: let id):
            return "/item/\(id)"
        case .deleteGoods(id: let id):
            return "/item/\(id)"
        }
    }
}
