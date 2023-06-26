//
//  NetworkManager.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation
import Alamofire

class NetworkManager {
    
    func performRequest(phoneNum: String, password: String, completion: @escaping (Result<TokenModel, Error>) -> Void) {
        let url = "https://dev.mobio.uz/api/login"

        let parameters: [String: Any] = [
            "phone": "998\(phoneNum)",
            "password": password
        ]

        AF.request(url, method: .post, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let token = try JSONDecoder().decode(TokenModel.self, from: jsonData)
                        completion(.success(token))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    // Handle the failure case
                    print("Error: \(error)")
                }
            }
    }
    
}
