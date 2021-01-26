//
//  OpenMarketTests.swift
//  OpenMarketTests
//
//  Created by Wonhee on 2021/01/26.
//

import XCTest
@testable import OpenMarket

class OpenMarketTests: XCTestCase {
    func testGoodsDecode() {
        let jsonDecoder = JSONDecoder()
        guard let goodsJSON = NSDataAsset(name: "item") else {
            return
        }
        let targetDescriptionData = "가장 얇고 가벼운 MacBook이 Apple M1 칩으로 완전히 새롭게 탈바꿈했습니다. 최대 3.5배 빨라진 CPU. 최대 5배 빨라진 GPU. 머신 러닝을 전보다 최대 9배 빠른 속도로 구동해주는 최첨단 Neural Engine. MacBook Air 사상 가장 긴 배터리 사용 시간. 그리고 조용한 팬리스 디자인까지. 이토록 놀라운 파워를 이토록 뛰어난 휴대성에 담아 최초로 선보입니다.\n드디어 찾아왔습니다. Mac용으로 Apple에서 직접 디자인한 최초의 칩. 160억 개라는 엄청난 수의 트랜지스터가 집적되어 있는 Apple M1 시스템 온 칩(SoC, System on Chip)은 자그마한 칩 하나에 CPU, GPU, Neural Engine, I/O 등 수많은 요소가 통합되어 있습니다. 놀라운 성능과 맞춤형 테크놀로지, 업계 최고 수준의 전력 효율을 자랑하는1 M1은 Mac의 성능을 단지 한 단계 높이는 것이 아니라 완전히 새로운 경지로 끌어올려주죠.\n2560 x 1600 해상도의 선명한 13.3형 Retina 디스플레이에서 이미지는 한 차원 높은 디테일로 생생하게 살아납니다. 텍스트는 더욱 또렷하고 선명하게 보이고, 컬러는 그 어느 때보다 강력한 생동감을 자아내죠. 게다가 글래스가 외장 가장자리까지 뻗어있기 때문에 그 어떤 시각적 방해 요소 없이 아름다운 화면을 온전히 감상할 수 있습니다."
        let targetThumbnailsData = [
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/thumbnails/1-1.png",
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/thumbnails/1-2.png",
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/thumbnails/1-3.png"
        ]
        let targetImagesData = [
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/images/1-1.png",
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/images/1-2.png",
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/images/1-3.png",
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/images/1-4.png",
            "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/images/1-5.png"
        ]
        
        do {
            let result = try jsonDecoder.decode(GoodsDetailItem.self, from: goodsJSON.data)
            let id = result.id
            let title = result.title
            let descriptions = result.descriptions
            let price = result.price
            let currency = result.currency
            let stock = result.stock
            let thumbnails = result.thumbnails
            let images = result.images
            let resigtrationDate = result.registrationDate
            
            XCTAssertEqual(1, id, "id Decode Error")
            XCTAssertEqual("MacBook Air", title, "title Decode Error")
            XCTAssertEqual(targetDescriptionData, descriptions, "descriptions Decode Error")
            XCTAssertEqual(1290000, price, "price Decode Error")
            XCTAssertEqual("KRW", currency, "currency Decode Error")
            XCTAssertEqual(1000000000000, stock, "stock Decode Error")
            XCTAssertEqual(targetThumbnailsData, thumbnails, "thumbnails Decode Error")
            XCTAssertEqual(targetImagesData, images, "images Decode Error")
            XCTAssertEqual(1611523563.719116, resigtrationDate, "resigtrationDate Decode Error")
            
        } catch {
            print(error)
        }
    }
    
    func testGoodsListDecode() {
        let jsonDecoder = JSONDecoder()
        guard let goodsListJSON = NSDataAsset(name: "items") else {
            return
        }
        
        do {
            let result = try jsonDecoder.decode(GoodsList.self, from: goodsListJSON.data)
            
            let page = result.page
            let firstItemId = result.items.first?.id
            let firstItemTitle = result.items.first?.title
            let firstItemPrice = result.items.first?.price
            let firstItemCurrency = result.items.first?.currency
            let firstItemStock = result.items.first?.stock
            let firstItemThumbnails = result.items.first?.thumbnails
            let firstItemRegistrationDate = result.items.first?.registrationDate
            
            let lastItemId = result.items.last?.id
            let lastItemTitle = result.items.last?.title
            let lastItemPrice = result.items.last?.price
            let lastItemCurrency = result.items.last?.currency
            let lastItemStock = result.items.last?.stock
            let lastItemThumbnails = result.items.last?.thumbnails
            let lastItemRegistrationDate = result.items.last?.registrationDate
            
            let targetFirstItemThumbnails = [
                "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/thumbnails/1-1.png",
                "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/thumbnails/1-2.png",
                "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/thumbnails/1-3.png"
            ]
            let targetLastItemThumbnails = [
                "https://camp-open-market.s3.ap-northeast-2.amazonaws.com/thumbnails/20-1.png"
            ]
            
            XCTAssertEqual(1, page, "page Decode Error")
            
            XCTAssertEqual(1, firstItemId, "firstItemId Decode Error")
            XCTAssertEqual("MacBook Air", firstItemTitle, "firstItemTitle Decode Error")
            XCTAssertEqual(1290000, firstItemPrice, "firstItemPrice Decode Error")
            XCTAssertEqual("KRW", firstItemCurrency, "firstItemCurrency Decode Error")
            XCTAssertEqual(1000000000000, firstItemStock, "firstItemStock Decode Error")
            XCTAssertEqual(targetFirstItemThumbnails, firstItemThumbnails, "firstItemThumbnails Decode Error")
            XCTAssertEqual(1611523563.719116, firstItemRegistrationDate, "firstItemRegistrationDate Decode Error")
            
            XCTAssertEqual(20, lastItemId, "lastItemId Decode Error")
            XCTAssertEqual("DJI Mavic Air 2", lastItemTitle, "lastItemTitle Decode Error")
            XCTAssertEqual(990, lastItemPrice, "lastItemPrice Decode Error")
            XCTAssertEqual("USD", lastItemCurrency, "lastItemCurrency Decode Error")
            XCTAssertEqual(0, lastItemStock, "lastItemStock Decode Error")
            XCTAssertEqual(targetLastItemThumbnails, lastItemThumbnails, "lastItemThumbnails Decode Error")
            XCTAssertEqual(1611523563.7466989, lastItemRegistrationDate, "lastItemRegistrationDate Decode Error")
        } catch {
            print(error)
        }
    }
}
