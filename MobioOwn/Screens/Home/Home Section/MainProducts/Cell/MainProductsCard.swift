//
//  MainProductsCard.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 05/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainProductsCard: View {
    
    let name: String
    let old_price: String
    let price: String
    let rate: Double
    let photoURL: String
    var percentage: Double {
        let priceDifference = Double(old_price)! - Double(price)!
        let decreasePercentage = (priceDifference / Double(old_price)!) * 100
        return decreasePercentage
    }
    
    var body: some View {
        VStack {
            ZStack {
                WebImage(url: URL(string: photoURL))
                    .resizable()
                    .scaledToFill()
                    .minimumScaleFactor(0.1)
                    .frame(width: 100, height: 80)
                    .padding(.top, 13)

                VStack {
                    HStack(alignment: .top) {
                        
                        Text(String(format: "%.2f", percentage) + " %")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 6))
                            .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                            .background(Color.pink)
                            .cornerRadius(10)
                            .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
                        
                        Spacer()
                        
                        VStack {
                            Button {
//                                print("Heart button tapped")
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 25, height: 25)
                                    
                                    Image(systemName: "heart")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14))
                                }
                                .padding(EdgeInsets(top: 6, leading: 6, bottom: 0, trailing: 6))
                            }
                            
                            Button {
//                                print("Heart button tapped")
                            } label: {
                                ZStack {
                                    Circle()
                                        .foregroundColor(.white)
                                        .frame(width: 25, height: 25)
                                    
                                    Image(systemName: "cart")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12))
                                }
                                .padding(EdgeInsets(top: 3, leading: 6, bottom: 0, trailing: 6))
                            }
                        }
                    }
                    Spacer()
                }
            }
            .frame(width: 140, height: 95)
            .background(Color.white)
            
            Spacer()

            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(price) сум")
                            .font(.system(size: 9))
                        Text("\(old_price) сум")
                            .font(.system(size: 8))
                            .foregroundColor(.secondary)
                            .strikethrough(true, color: Color.red)
                    }
                    .bold()
                    .padding(.top, 8)
                    Spacer()

                    HStack(alignment: .center, spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 8))

                        Text(String(format: "%.2f", rate))
                            .font(.system(size: 10))
                    }
                    .foregroundColor(Color.white)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.pink)
                    .cornerRadius(3)
                }
                
                Text(name)
                    .font(.system(size: 8))
                    .padding(.bottom, 10)
            }
            .padding(.horizontal, 6)
            .background(Color.white)
            
        }
        .frame(width: 140, height: 170)
        .background(Color.white)
        .cornerRadius(8)
        .offset(x: 10)
        .shadow(radius: 5)
    }
}


//struct MainProductsCard_Previews: PreviewProvider {
//    static var previews: some View {
//        MainProductsCard()
//    }
//}
