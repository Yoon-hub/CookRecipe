//
//  CookRecipe.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

// MARK: - CookRecipe
struct CookRecipe: Codable, Hashable {
    let cookrcp01: Cookrcp01

    enum CodingKeys: String, CodingKey {
        case cookrcp01 = "COOKRCP01"
    }
}

// MARK: - Cookrcp01
struct Cookrcp01: Codable, Hashable {
    let totalCount: String
    let row: [[String: String]]
    let result: Result

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case row
        case result = "RESULT"
    }
}

// MARK: - Result
struct Result: Codable, Hashable {
    let msg, code: String

    enum CodingKeys: String, CodingKey {
        case msg = "MSG"
        case code = "CODE"
    }
}
