//
//  LoginViewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/03.
//

import Foundation

import RxSwift
import RxCocoa

final class LoginViewModel {

    let email = PublishSubject<String>() // 필요없는디?
    let password = PublishSubject<String>() // 필요없는디?
    
    let disposeBag = DisposeBag()
    
    func requestLogin(email: String, password: String, completion: @escaping (APILoginResult<Login, Int>) -> Void) {
        APIService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let token) :
                completion(.success(token))
            case .failure(let status) :
                completion(.failure(status))
            }
        }
    }
}
