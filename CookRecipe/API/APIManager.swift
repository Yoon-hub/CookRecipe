//
//  APIManager.swift
//  CookRecipe
//
//  Created by 최윤제 on 2022/10/20.
//

import Foundation

class APIManager {
    
    typealias completion = (CookRecipe?, APIError?) -> Void
    
    private init() {}
    
    static let shared = APIManager()
    
    func requsetAPI(text: String, completion: @escaping completion) {
        
        let query = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(APIKey.url)\(query)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Failed Request")
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returend")
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completion(nil, .invalidRessponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    return
                }
                
                do  {
                    let result = try JSONDecoder().decode(CookRecipe.self, from: data)
                    completion(result, nil)
                } catch {
                    //print(error)
                    completion(nil, .invalidData)
                }
            }
        }.resume()
    }
}
