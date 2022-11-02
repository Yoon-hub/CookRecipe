//
//  APIService.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/03.
//

import Foundation

import Alamofire

final class APIService {
    
    private init() {}
    
    static let shared = APIService()
    
    typealias Completion = (APILoginResult<Login, Int>) -> Void
    
    
    func signup(userName: String, email: String, password: String) {
        let api = SeSACAPI.signup(userName: userName, email: email, password: password)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers).responseString { response in
            switch response.result {
            case let .success(value):
                print(value)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping Completion) {
        let api = SeSACAPI.login(email: email, password: password)
        AF.request(api.url, method: .post, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
                UserDefaults.standard.set(data.token, forKey: "token")
            case .failure(_):
                completion(.failure(response.response?.statusCode ?? 0))
               // print(response.response?.statusCode)
            }
        }
    }

    
    
    func profile() {
        let api = SeSACAPI.profile
        AF.request(api.url, method: .get, headers: api.headers).responseDecodable(of: Profile.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(_):
                print(response.response?.statusCode)
            }
        }
    }
    
}
