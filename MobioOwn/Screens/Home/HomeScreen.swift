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

enum MenuSection {
    case glavnoeOkno
    case departamenti
    case izobrannie
    case cherezZadachamiVoprosi
    case vetvi
    case nastroyki
}

struct HomeScreen: View {
    @EnvironmentObject var profile: Profile
    
    @StateObject var viewModel = HomeScreenViewModel()
    
    @State var selectedTab: Section = .home
    
    @State var isMenuOpen = false
    @State var selectedMenu: MenuSection = .glavnoeOkno
//    @State var backroundColor: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch selectedMenu {
                case .glavnoeOkno:
                    VStack {
                        Spacer()
                        
                        switch selectedTab {
                        case .search:
                            SearchViewSection()
                        case .home:
                            HomeViewSection()
                        case .basket:
                            BasketViewSection()
                        }
                        
                        Spacer()
                        
                        TabbarView(selectedSection: $selectedTab)
                            .background(Color.white)
                    }
                case .departamenti:
                    Text("Welcome to departamenti")
                case .izobrannie:
                    Text("Welcome to izobrannie")
                    
                case .cherezZadachamiVoprosi:
                    Text("Welcome to cherezZadachamiVoprosi")
                    
                case .vetvi:
                    Text("Welcome to vetvi")
                    
                case .nastroyki:
                    Text("Welcome to nastroyki")
                    
                }
                
                GeometryReader { screen in
                    HStack(spacing: 0) {
                        VStack {
                            ScrollView {
                                VStack(spacing: 10) {
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2).delay(0.0)) {
                                            selectedMenu = .glavnoeOkno
                                        }
                                        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                                            isMenuOpen = false
                                        }
                                    } label: {
                                        ButtonStyle(title: "Главное окно", iconName: "house.fill", color: selectedMenu == .glavnoeOkno ? Color.pink.opacity(0.15) : .clear, imageColor: selectedMenu == .glavnoeOkno ? Color.red : .gray)
                                    }
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2).delay(0.0)) {
                                            selectedMenu = .departamenti
                                        }
                                        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                                            isMenuOpen = false
                                        }
                                    } label: {
                                        ButtonStyle(title: "Департаменты", iconName: "keyboard", color: selectedMenu == .departamenti ? Color.pink.opacity(0.15) : .clear, imageColor: selectedMenu == .departamenti ? Color.red : .gray)
                                    }
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2).delay(0.0)) {
                                            selectedMenu = .izobrannie
                                        }
                                        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                                            isMenuOpen = false
                                        }
                                    } label: {
                                        ButtonStyle(title: "Избранное", iconName: "heart", color: selectedMenu == .izobrannie ? Color.pink.opacity(0.15) : .clear, imageColor: selectedMenu == .izobrannie ? Color.red : .gray)
                                    }
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2).delay(0.0)) {
                                            selectedMenu = .cherezZadachamiVoprosi
                                        }
                                        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                                            isMenuOpen = false
                                        }
                                    } label: {
                                        ButtonStyle(title: "Часто задаваемые вопросы", iconName: "questionmark.app", color: selectedMenu == .cherezZadachamiVoprosi ? Color.pink.opacity(0.15) : .clear, imageColor: selectedMenu == .cherezZadachamiVoprosi ? Color.red : .gray)
                                    }
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2).delay(0.0)) {
                                            selectedMenu = .vetvi
                                        }
                                        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                                            isMenuOpen = false
                                        }
                                    } label: {
                                        ButtonStyle(title: "Ветви", iconName: "square.grid.3x1.folder.badge.plus", color: selectedMenu == .vetvi ? Color.pink.opacity(0.15) : .clear, imageColor: selectedMenu == .vetvi ? Color.red : .gray)
                                    }
                                    
                                    Button {
                                        withAnimation(.easeInOut(duration: 0.2).delay(0.0)) {
                                            selectedMenu = .nastroyki
                                        }
                                        withAnimation(.easeInOut(duration: 0.5).delay(0.1)) {
                                            isMenuOpen = false
                                        }
                                    } label: {
                                        ButtonStyle(title: "Настройки", iconName: "gear", color: selectedMenu == .nastroyki ? Color.pink.opacity(0.15) : .clear, imageColor: selectedMenu == .nastroyki ? Color.red : .gray)
                                        
                                    }
                                }
                            }
                            Spacer()
                        }.frame(width: screen.size.width * 0.65, height: screen.size.height)
                            .background(Color.white)

                        VStack {
                            
                        }.frame(width: screen.size.width * 0.35, height: screen.size.height)
//                            .background(backroundColor ? Color.gray.opacity(0.5) : Color.white.opacity(0.0))
                            .background(Color.white.opacity(0.001))
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isMenuOpen = false
                                }
                                
//                                withAnimation(.easeInOut(duration: 0.0).delay(2.0)) {
//                                    backroundColor.toggle()
//                                }
                            }
                    }.frame(width: screen.size.width, height: screen.size.height)
                        .offset(x: isMenuOpen ? 0 : -screen.size.width)
                        .transition(.move(edge: .leading))
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading:
                                    Button(action: {
                print("navigation bar button tapped")
                withAnimation(.easeInOut(duration: 0.5)) {
                    isMenuOpen.toggle()
                }
                
//                withAnimation(.easeInOut(duration: 0.0).delay(2.0)) {
//                    backroundColor.toggle()
//                }
                
            }) {
                Image("menu")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.red)
                    .bold()
            })
            //            .navigationBarItems(trailing:
            //                                    Button(action: {
            ////                print("navigation bar button tapped")
            //                profile.isUserLoggedIn = false
            //                viewModel.deleteToken()
            //            }) {
            //                Image(systemName: "square.and.arrow.up")
            //                    .foregroundColor(.red)
            //                    .bold()
            //            })
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}



fileprivate struct ButtonStyle: View {
    let title: String
    let iconName: String
    let color: Color
    let imageColor: Color
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .padding(.leading)
                .foregroundColor(imageColor)
            Text(title)
                .foregroundColor(.gray)
                .font(.system(size: 12))
            
            Spacer()
        }
        .padding(.vertical)
        .background(color)
        .cornerRadius(8)
        .padding(.horizontal, 10)
    }
}
