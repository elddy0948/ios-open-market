//
//  NetworkError.swift
//  OpenMarket
//
//  Created by Wonhee on 2021/01/26.
//

import Foundation

enum NetworkError: Error {
    case network
    case getData
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .network:
            return "네트워크 통신 중 문제가 발생했습니다.\n잠시 후 다시 시도해주세요."
        case .getData:
            return "데이터를 가져오는 중 문제가 발생했습니다.\n잠시 후 다시 시도해주세요."
        }
    }
}
