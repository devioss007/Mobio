//
//  RegistrationViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 26/06/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    // MARK: - Services
    
    private let service = NetworkManager()
    
    func changeButtonOpacity(phoneNumber: String, password: String, fullname: String, email: String) -> Double {
        return (phoneNumber.count == 9 && password.count >= 8 && !fullname.isEmpty && !email.isEmpty) ? 1.0 : 0.5
    }
    
    func changeButtonCondition(phoneNumber: String, password: String, fullname: String, email: String) -> Bool {
        return !(phoneNumber.count == 9 && password.count >= 8 && !fullname.isEmpty && !email.isEmpty)
    }
    
    func registerUser(phoneNumber: String, password: String, fullname: String, email: String, completion: @escaping (Bool, String)->(Void)) {
        service.performRequestForRegister(phoneNumber: phoneNumber, password: password, fullname: fullname, email: email) { response in
            switch response {
            case .success(let response):
                completion(true, response.message)
            case .failure(let error):
                completion(false, error.localizedDescription)
            }
        }
    }
}
