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

//struct HomeScreen: View {
//    @EnvironmentObject var profile: Profile
//
//    let tokenService = UserDefaultsManager()
//    var body: some View {
//        VStack {
//            Text("Welcome to Home Screen")
//                .padding(.top, 60)
//            Spacer()
//            Button {
//                profile.isLoggedIn = false
//                tokenService.deleteToken()
//            } label: {
//                HStack {
//                    Spacer()
//                    Text("Log Out")
//                    Spacer()
//
//                }
//                .padding(24)
//                .background(.gray)
//                .cornerRadius(12)
//                .foregroundColor(Color.white)
//                .padding(.horizontal, 20)
//            }
//
//            Spacer()
//        }
//
//    }
//}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
