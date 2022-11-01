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
        let ingredient = data[RowDictionary.ingredient.rawValue]!.replacingOccurrences(of: "재료 ", with: "").replacingOccurrences(of: "\n", with: ", ")
        let midleInfo = CookItem.middle(CookIngredient(ingredient: ingredient))
        
        let bottomInfo = getRecipe(data: data)
        
        let section = [
            SectionCookInfo(header:"" ,items: [topInfo]),
            SectionCookInfo(header:"식재료" ,items: [midleInfo]),
            SectionCookInfo(header:"레시피" ,items: bottomInfo)
        ]
        cookInfo.onNext(section)
    }
    
    private func getRecipe(data: [String:String]) -> [CookItem] {
        var bottomInfo: [CookItem] = []
        
        Recipe.allCases.forEach {
            if data[$0.rawValue]! == "" {
                return
            } else {
                let content = data[$0.rawValue]!.replacingOccurrences(of: "\n", with: " ")
                let item = CookItem.bottom(RecipeSection(content: content))
                bottomInfo.append(item)
            }
        }
        return bottomInfo
    }
}

// Input Output Pattern
extension DetailViewModel: CommonViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        let cookInfo: PublishSubject<[SectionCookInfo]>
    }
    
    func transform(input: Input) -> Output {
     
        return Output(cookInfo: cookInfo)
    }
}


