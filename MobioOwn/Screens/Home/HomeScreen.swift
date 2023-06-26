//
//  HomeScreen.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import SwiftUI

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
                    TabButton1()
                case .home:
                    TabButton2()
                case .basket:
                    TabButton3()
                }
                
                Spacer()
                TabbarView(selectedSection: $selectedTab)
                    .background(Color.white)
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(trailing:
                                    Button(action: {
                print("navigation bar button tapped")
                profile.isUserLoggedIn = false
                viewModel.deleteToken()
            }) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.red)
                    .bold()
            })
        }
    }
}

struct TabButton1: View {
    
    var body: some View {
        Text("TabButton1")
    }
}

struct TabButton2: View {
    
    var body: some View {
        Text("TabButton2")
    }
}

struct TabButton3: View {
    
    var body: some View {
        Text("TabButton3")
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}



struct TabbarView: View {
    
    @Binding var selectedSection: Section
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                selectedSection = .search
                print("Search button tapped")
            }, label: {
                HStack {
                    Spacer()
                    
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(selectedSection == .search ? .red : .gray)
                        .font(.system(size: 20))
                        .bold()
                    
                    Spacer()
                    
                }
            })
            
            Spacer()
            
            Button(action: {
                selectedSection = .home
                print("Home button tapped")
            }, label: {
                HStack {
                    Spacer()
                    
                    Image(systemName: "house.fill")
                        .foregroundColor(selectedSection == .home ? .red : .gray)
                        .font(.system(size: 20))
                        .bold()
                    
                    Spacer()
                    
                }
            })
            
            Spacer()
            
            Button(action: {
                selectedSection = .basket
                print("Basket button tapped")
            }, label: {
                HStack {
                    Spacer()
                    
                    Image(systemName: "cart")
                        .foregroundColor(selectedSection == .basket ? .red : .gray)
                        .font(.system(size: 20))
                        .bold()
                    Spacer()
                    
                }
            })
            
            Spacer()
        }
        .padding(.top, 25)
        .padding(.bottom, 35)
        .cornerRadius(25)
        .background(Color.gray.opacity(0.2))
    }
}
