//
//  TabbarView.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 27/06/23.
//

import SwiftUI

struct TabbarView: View {
    
    @Binding var selectedSection: Section
    
    var body: some View {
        HStack {
            Spacer()
            
            Button(action: {
                selectedSection = .search
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

//struct TabbarView_Previews: PreviewProvider {
//    static var previews: some View {
//        TabbarView()
//    }
//}
