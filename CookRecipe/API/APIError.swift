//
//  APIError.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

enum APIError: Error {
    case invalidRessponse
    case noData
    case failedRequest
    case invalidData
}
