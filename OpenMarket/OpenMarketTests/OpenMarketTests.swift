//
//  OpenMarketTests.swift
//  OpenMarketTests
//
//  Created by 김호준 on 2021/01/26.
//

import XCTest
@testable import OpenMarket

class OpenMarketTests: XCTestCase {
    var request = RegisterGoodsAPI()
    
    func test_networkconfig_makeurl_method() {
        guard let url = URL(string: "https://camp-open-market.herokuapp.com/items/1") else {
            XCTFail("Error with URL")
            return
        }
        XCTAssertEqual(NetworkConfig.makeURL(with: .fetchGoodsList(page: 1)), url)
    }
    
    func test_API_request() {
        guard let testImage = UIImage(named: "test1")?.jpegData(compressionQuality: 0.8) else {
            return
        }
        
        let form = GoodsForm(title: "test-joons", descriptions: "desc", price: 100000000, currency: "KRW", stock: 1, discountedPrice: nil, images: [testImage], password: "1234")
        let urlRequest = request.makeRequest(from: form).urlRequest
        
        XCTAssertEqual(urlRequest.httpMethod, "POST")
        XCTAssertNotNil(urlRequest.httpBody)
        XCTAssertEqual(urlRequest.url, NetworkConfig.makeURL(with: .registerGoods))
    }
    
    func test_parse_response() {
        guard let url = Bundle.main.url(forResource: "ResponseMock", withExtension: "json") else {
            XCTFail("Can't find Mock Data")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
//            let json = try JSONDecoder().decode(Goods.self, from: data)
            let parseData = try request.parseResponse(data: data)
            print(parseData)
        } catch let error {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_fetch_data_from_server() {
        let expectation = XCTestExpectation(description: "fetch data")
        
        guard let url = URL(string: "https://camp-open-market.herokuapp.com/items/1") else {
            XCTFail("Error with URL")
            return
        }
                
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error != nil {
                XCTFail("Network error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                XCTFail("Status Code error!")
                return
            }
            
            guard data != nil else {
                XCTFail("No Data!")
                return
            }
            expectation.fulfill()
        }.resume()
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_decode_mock_data_with_market_model() {
        guard let mockURL = Bundle.main.url(forResource: "Mock", withExtension: "json") else {
            XCTFail("Can't get json file")
            return
        }
        do {
            let mockRawData = try Data(contentsOf: mockURL)
            let mockDecodedJSON = try JSONDecoder().decode(MarketGoods.self,
                                                    from: mockRawData)
            XCTAssertEqual(mockDecodedJSON.page, 1)
            XCTAssertEqual(mockDecodedJSON.list[0].id, 26)
            XCTAssertEqual(mockDecodedJSON.list[0].currency, "KRW")
        } catch {
            XCTFail()
            return
        }
    }
    
    func test_decode_mock_data_with_goods_model() {
        guard let mockURL = Bundle.main.url(forResource: "MockItem", withExtension: "json") else {
            XCTFail()
            return
        }
        do {
            let mockRawData = try Data(contentsOf: mockURL)
            let mockDecodedJSON = try JSONDecoder().decode(Goods.self, from: mockRawData)
            XCTAssertNotNil(mockDecodedJSON.descriptions)
            XCTAssertNotNil(mockDecodedJSON.images)
            XCTAssertNil(mockDecodedJSON.discountedPrice)
        } catch {
            XCTFail()
            return
        }
    }
}
