//
//  DetailViewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/30.
//

import Foundation

import RxSwift

final class DetailViewModel {
    
    let cookInfo = PublishSubject<[SectionCookInfo]>()
    
    func fetchInfo(data: [String:String]) {
        
        let topInfo = CookItem.top(CookInfo(name: data[RowDictionary.title.rawValue]!,favorite: true ))
        let ingredient = data[RowDictionary.ingredient.rawValue]!.replacingOccurrences(of: "재료 ", with: "")
        let midleInfo = CookItem.middle(CookIngredient(ingredient: ingredient))
        
        let section = [
            SectionCookInfo(header:"" ,items: [topInfo]),
            SectionCookInfo(header:"식재료" ,items: [midleInfo])
        ]
        cookInfo.onNext(section)
    }
    
}
