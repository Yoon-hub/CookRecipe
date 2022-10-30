//
//  CookInfo.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/30.
//

import Foundation

import RxDataSources

struct CookInfo {
    var name: String
    var favorite: Bool
}

struct CookIngredient{
    var ingredient: String
}

enum CookItem {
    case top(CookInfo)
    case middle(CookIngredient)
}


struct SectionCookInfo {
    var header: String
    var items: [Item]
}

extension SectionCookInfo: SectionModelType {
  typealias Item = CookItem

   init(original: SectionCookInfo, items: [Item]) {
    self = original
    self.items = items
  }
}
