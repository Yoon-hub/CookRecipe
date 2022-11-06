//
//  ProfileViewModel.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/11/04.
//

import Foundation

final class ProfileViewModel {
    
    func requestProfile(completion: @escaping (Result<Profile, Error>) -> Void) {
        let api = SeSACAPI.profile
        APIService.shared.apiIntegration(type: Profile.self, api: api, method: .get) { result, statusCode in
            switch result{
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
