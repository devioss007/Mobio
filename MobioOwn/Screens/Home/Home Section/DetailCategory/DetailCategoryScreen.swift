//
//  DetailCategoryScreen.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 04/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailCategoryScreen: View {
    
    let items: [HomeScreenItems]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                ForEach(items, id: \.self) { item in
                    VStack {
                        
                        if let url = item.photo_cat {
                            WebImage(url: URL(string: "https://dev.mobio.uz/storage/\(url.id)/\(url.file_name)"))
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                        } else {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.gray)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(25)
                                ProgressView()
                            }
                        }
                        //
                        //                        Circle()
                        //                            .frame(width: 60, height: 60)
                        Text(item.name)
                            .multilineTextAlignment(.center)
                            .scaledToFit()
                            .font(.system(size: 10))
                            .lineLimit(nil)
                            .padding(.horizontal)
                    }
                    
                }
            }
            .padding()
        }
    }
}

//struct DetailCategoryScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCategoryScreen()
//    }
//}
