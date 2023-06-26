//
//  UserDefaultsManager.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation

class UserDefaultsManager {
    
    enum Token: String {
        case token_type = "token_type"
        case expires_in = "expires_in"
        case access_token = "access_token"
        case refresh_token = "refresh_token"
    }
    
    func saveToken(token: TokenModel) {
        UserDefaults.standard.set(token.expires_in, forKey: UserDefaultsManager.Token.expires_in.rawValue)
        UserDefaults.standard.set(token.access_token, forKey: UserDefaultsManager.Token.access_token.rawValue)
        UserDefaults.standard.set(token.refresh_token, forKey: UserDefaultsManager.Token.refresh_token.rawValue)
        UserDefaults.standard.set(token.token_type, forKey: UserDefaultsManager.Token.token_type.rawValue)
    }
    
    func deleteToken() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsManager.Token.expires_in.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsManager.Token.access_token.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsManager.Token.refresh_token.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsManager.Token.token_type.rawValue)
    }
    
}
