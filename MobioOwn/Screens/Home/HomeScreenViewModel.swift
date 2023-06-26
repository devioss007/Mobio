//
//  HomeScreenViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation

final class HomeScreenViewModel: ObservableObject {
    
    func deleteToken() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsManager.Token.access_token.rawValue)
    }
}
