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
//                    print("Error: \(error)")
                }
            }
    }
    
    
    func getAllDataForHomeScreen(page: Int, completion: @escaping (Result<[HomeScreenItems], Error>) -> Void) {
        let url = "https://dev.mobio.uz/api/category"
        
        let parameters: [String: Any] = [
            "count": 10,
            "page": page
        ]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let response = try JSONDecoder().decode(HomeScreenModel.self, from: jsonData)
                        completion(.success(response.category.data))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
//                    print("Error: \(error)")
                }
            }
    }
    
    func getMainProducts(completion: @escaping (Result<MainProductsModel, Error>) -> Void) {
        let url = "https://dev.mobio.uz/api/products/main"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let response = try JSONDecoder().decode(MainProductsModel.self, from: jsonData)
//                        print("salom")
                        completion(.success(response))
                    } catch {
//                        print("alik")
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
//                    print("Error: \(error)")
                }
            }
    }
    
    func getmainChildProducts(completion: @escaping (Result<MainChildProductsModel, Error>) -> Void) {
        let url = "https://dev.mobio.uz/api/products/mainChild"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let response = try JSONDecoder().decode(MainChildProductsModel.self, from: jsonData)
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
    
    
    func getCategoryProducts(id: Int, completion: @escaping (Result<CategoryProductsModel, Error>) -> Void) {
        let url = "https://dev.mobio.uz/api/productbycategory/\(id)"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]

        AF.request(url, method: .get, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: value)
                        let response = try JSONDecoder().decode(CategoryProductsModel.self, from: jsonData)
                        completion(.success(response))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
