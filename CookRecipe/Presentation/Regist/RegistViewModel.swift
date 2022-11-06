//
//  RegistViewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/06.
//

import Foundation

final class RegistViewModel {
    
    func requestRegist(userName: String, email: String, password: String, completion: @escaping (Result<Regist, Error>, Int) -> Void) {
        let api = SeSACAPI.signup(userName: userName, email: email, password: password)
        
        APIService.shared.apiIntegration(type: Regist.self, api: api, method: .post) { response, statusCode in
            switch response {
            case .success(let success):
                completion(.success(success), statusCode)
            case .failure(let failure):
                completion(.failure(failure), statusCode)
            }
        }
    }
    
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
