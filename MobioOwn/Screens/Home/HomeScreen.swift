//
//  HomeScreen.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var profile: Profile

    @StateObject var viewModel = HomeScreenViewModel()
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Welcome to Home Screen")
            Button {
                viewModel.logOutButtonTapped(profile: profile)
            } label: {
                Text("Log Out")
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
