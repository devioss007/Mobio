//
//  HomeScreenViewModel.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import Foundation

final class HomeScreenViewModel: ObservableObject {
    
    // MARK: - Input
    
    func logOutButtonTapped(profile: Profile) {
        doLogOut(profile: profile)
    }
    
    // MARK: - Private functions
    private func doLogOut(profile: Profile) {
        UserDefaults.standard.removeObject(forKey: KEY)
        profile.isUserLoggedIn = false
    }
}
