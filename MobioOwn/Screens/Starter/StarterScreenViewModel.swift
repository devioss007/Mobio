//
//  StarterScreenViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation

final class Profile: ObservableObject {
    @Published var isUserLoggedIn: Bool
    
    init() {
        let token = UserDefaults.standard.string(forKey: UserDefaultsManager.Token.access_token.rawValue)
        isUserLoggedIn = (token != nil)
    }
}
