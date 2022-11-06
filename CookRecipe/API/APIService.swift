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
    
    func apiIntegration<T: Decodable>(type: T.Type = T.self, api: SeSACAPI, method: HTTPMethod, completion: @escaping (Result<T, Error>, Int) -> Void) {
        AF.request(api.url, method: method, parameters: api.parameters, headers: api.headers).responseDecodable(of: T.self) { response in
            switch response.result{
            case .success(let data):
                completion(.success(data), response.response!.statusCode)
            case .failure(let error):
                completion(.failure(error), response.response!.statusCode)
            }
        }
    }
    
}
