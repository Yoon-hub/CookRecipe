//
//  MainVIewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/21.
//

import Foundation

final class MainViewModel {
    
    var recipeList: Observalble<CookRecipe> = Observalble(CookRecipe(cookrcp01: Cookrcp01(totalCount: "", row: [[:]], result: Result(msg: "", code: ""))))
    
    func requestRecipe(text: String, completion: @escaping () -> ()){
        
        APIManager.shared.requsetAPI(text: text) { [weak self] result, error in
            if error == .invalidData { completion() }
            guard let result = result else {return}
            self?.recipeList.value = result
        }
    }
}
