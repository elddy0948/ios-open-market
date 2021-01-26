//
//  OpenMarket - ViewController.swift
//  Created by yagom. 
//  Copyright © yagom. All rights reserved.
// 

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        MarketNetwork.searchGoodsList(with: 1)
//        MarketNetwork.searchGoods(to: 97)
//        let editGoods = EditGoodsForm(title: "testtesttest", descriptions: nil, price: nil, currency: nil, stock: nil, discountedPrice: nil, images: nil, password: "1234")
//        MarketNetwork.editGoods(to: 98, with: editGoods)
//        MarketNetwork.deleteGoods(to: 97)
        let testImage = UIImage(named: "test1")
        guard let testData = testImage?.jpegData(compressionQuality: 0.8)?.base64EncodedString() else {
            debugPrint("🥺 fail convert UIImage to data")
            return
        }
        let addGoods = RegisterGoodsForm(title: "testFor", descriptions: "testFor", price: 1000000000, currency: "USD", stock: 10000000000, discountedPrice: 2, images: [testData], password: "1234")
        MarketNetwork.registerGoods(with: addGoods)
    }
}

