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
    
    func performRequestForRegister(phoneNumber: String, password: String, fullname: String, email: String, completion: @escaping (Result<RegistrationModel, Error>) -> Void) {
        
        let url = "https://dev.mobio.uz/api/register"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]

        let parameters: [String: Any] = [
            "email": email,
            "name": fullname,
            "password": password,
            "phone": "998\(phoneNumber)",
        ]
        
        print("paramet", parameters)

        AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let response = try JSONDecoder().decode(RegistrationModel.self, from: jsonData)
                        completion(.success(response))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                    print("Error: \(error)")
                }
            }
    }
    
}
