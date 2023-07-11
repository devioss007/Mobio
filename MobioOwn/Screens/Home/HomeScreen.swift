//
//  HomeScreen.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import SwiftUI
import Shimmer
enum Section {
    case search
    case home
    case basket
}

struct HomeScreen: View {
    @EnvironmentObject var profile: Profile
    
    @StateObject var viewModel = HomeScreenViewModel()
    
    @State var selectedTab: Section = .home
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                switch selectedTab {
                case .search:
                    SearchViewSection()
                case .home:
                    HomeViewSection()
                case .basket:
                    Text("Tab bar view 3")
                }
                
                Spacer()
                TabbarView(selectedSection: $selectedTab)
                    .background(Color.white)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(trailing:
                                    Button(action: {
//                print("navigation bar button tapped")
                profile.isUserLoggedIn = false
                viewModel.deleteToken()
            }) {
                Text("Log out")
                    .font(.system(size: 12))
                    .foregroundColor(.pink)
            })
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}


