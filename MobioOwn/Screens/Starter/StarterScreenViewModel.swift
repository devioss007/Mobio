//
//  StarterScreenViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation
let KEY = "TOKEN"

final class Profile: ObservableObject {
    @Published var isUserLoggedIn: Bool
    
    init() {
        let token = UserDefaults.standard.string(forKey: KEY)
        isUserLoggedIn = (token != nil)
    }
}
