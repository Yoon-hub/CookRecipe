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

struct RecipeSection {
    var content: String
}

enum CookItem {
    case top(CookInfo)
    case middle(CookIngredient)
    case bottom(RecipeSection)
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


