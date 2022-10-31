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
    
    func requestRecipe(text: String,  completion: @escaping (String) -> Void){
        
        APIManager.shared.requsetAPI(text: text) { result in
            switch result {
            case let .success(data):
                self.recipeList.onNext(data)
            case let .failure(error):
                switch error {
                case .invalidData, .failedResponse, .invalidRessponse, .noData, .failedRequest:
                    completion(error.rawValue)
                }
                
            }
        }
    }
    
}
