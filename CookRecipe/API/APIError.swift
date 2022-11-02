//
//  APIError.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

enum APIResult<T, G: Error> {
    case success(T)
    case failure(G)
}

enum APILoginResult<T, G> {
    case success(T)
    case failure(G)
}

enum APIError: String, Error {
    case invalidRessponse = "응답이 없습니다."
    case noData = "데이터가 없습니다."
    case failedRequest = "요청에 실패 하였습니다."
    case invalidData = "검색어와 일치하는 레시피가 없습니다."
    case failedResponse = "응답을 받을 수 없습니다."
}
