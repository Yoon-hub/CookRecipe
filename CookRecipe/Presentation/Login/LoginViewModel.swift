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
    
    func requestLogin(email: String, password: String, completion: @escaping (Result<Login, Error>) -> Void) {
        let api = SeSACAPI.login(email: email, password: password)
        APIService.shared.apiIntegration(type: Login.self, api: api, method: .post) { response, statusCode in
            switch response {
            case .success(let data):
                UserDefaults.standard.set(data.token, forKey: "token")
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
