//
//  MainVIewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/21.
//

import Foundation

class MainViewModel {
    
    var recipeList: Observalble<CookRecipe> = Observalble(CookRecipe(cookrcp01: Cookrcp01(totalCount: "", row: [[:]], result: Result(msg: "", code: ""))))
    
    func requestRecipe(text: String){
        
        APIManager.shared.requsetAPI(text: text) { result, error in
            if error == .invalidData { print("그런 레시피는 없어요") }
            guard let result = result else {return}
            self.recipeList.value = result
        }
    }
}
