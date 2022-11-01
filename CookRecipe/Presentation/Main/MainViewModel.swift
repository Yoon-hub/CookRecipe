//
//  MainVIewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/21.
//

import Foundation

import RxSwift
import RxCocoa

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

// Input Output Pattern
extension MainViewModel: CommonViewModel {
    
    struct Input {
        let searchBar: ControlProperty<String?>
    }
    
    struct Output {
        let recipeList: PublishSubject<CookRecipe>
        let searchBar: Observable<ControlProperty<String>.Element>
    }
    
    func transform(input: Input) -> Output {
        let searchbar = input.searchBar.orEmpty
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
        return Output(recipeList: recipeList, searchBar: searchbar)
    }
}


