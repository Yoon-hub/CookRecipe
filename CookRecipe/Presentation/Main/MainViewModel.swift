//
//  MainVIewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/21.
//

import Foundation

import RxSwift

final class MainViewModel {
    
//    var recipeList: Observalble<CookRecipe> = Observalble(CookRecipe(cookrcp01: Cookrcp01(totalCount: "", row: [[:]], result: Result(msg: "", code: ""))))
    
    var recipeList = PublishSubject<CookRecipe>()
    
    func requestRecipe(text: String){
        
        APIManager.shared.requsetAPI(text: text) { [weak self] result, error in
            if error == .invalidData {
                self?.recipeList.onError(error!)
                return
            }
            guard let result = result else {return}
            self?.recipeList.onNext(result) 
        }
    }
}
