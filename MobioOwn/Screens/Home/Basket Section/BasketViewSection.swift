//
//  BasketViewSection.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 11/07/23.
//

import SwiftUI

struct BasketViewSection: View {
    var body: some View {
        VStack {
            Spacer()
            
            LottieView(lottieFile: "empty.json")
                .frame(width: 180, height: 180)
            Text("Информация недоступна")
                .font(.system(size: 12))
                .padding(.top, 4)

            
            Spacer()
        }
    }
}

struct BasketViewSection_Previews: PreviewProvider {
    static var previews: some View {
        BasketViewSection()
    }
}
