//
//  LoginViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation

class LoginViewModel: ObservableObject {

    // MARK: - Services
    
    private let service = NetworkManager()
    private let tokenService = UserDefaultsManager()

    func authenticateUser(phoneNumber: String, password: String, completion: @escaping (Bool)->(Void)){
        service.performRequest(phoneNum: phoneNumber, password: password) { response in
            switch response {
            case .success(let token):
                self.tokenService.saveToken(token: token)
                completion(true)
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
    
    func changeButtonOpacity(phoneNumber: String, password: String) -> Double {
        return (phoneNumber.count == 9 && password.count >= 8) ? 1.0 : 0.5
    }
    
    func changeButtonCondition(phoneNumber: String, password: String) -> Bool {
        return !(phoneNumber.count == 9 && password.count >= 8)
    }
    
}
