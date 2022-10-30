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

enum CookItem {
    case top(CookInfo)
}


struct SectionCookInfo {
    var items: [Item]
}

extension SectionCookInfo: SectionModelType {
  typealias Item = CookInfo

   init(original: SectionCookInfo, items: [Item]) {
    self = original
    self.items = items
  }
}
