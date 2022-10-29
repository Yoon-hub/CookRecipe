//
//  MainVIewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/21.
//

import Foundation

import RxSwift

final class MainViewModel {
    
    var recipeList = PublishSubject<CookRecipe>()
    
    func requestRecipe(text: String,  completion: @escaping () -> Void){
        
        APIManager.shared.requsetAPI(text: text) { [weak self] result, error in
            if error == .invalidData {
                //self?.recipeList.onError(error!) // 구독이 종료 되버린다
                completion()
                return
            }
            guard let result = result else {return}
            self?.recipeList.onNext(result) 
        }
    }
}
