//
//  SearchViewSection.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 06/07/23.
//

import SwiftUI
import Lottie

struct SearchViewSection: View {
    @State private var text: String = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 6) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.red)
                    .bold()
                    .font(.system(size: 14))
                    .padding(.leading, 8)
                
                TextField("Поиск...", text: $text)
            }
            .frame(height: 38)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red, lineWidth: 1)
            )
            .padding()
            
            Spacer()
            
            LottieView(lottieFile: "search.json")
                .frame(width: 180, height: 180)
            Text("Раздел поиска ")
                .offset(y: -26)
                .font(.system(size: 12))

            
            Spacer()
            
        }
        
    }
}

struct SearchViewSection_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewSection()
    }
}

struct LottieView: UIViewRepresentable {
    let lottieFile: String
    
    let animationView = LottieAnimationView()
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)
        
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        animationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}


//1)Search
//api/product
//
//querysiga search junatiladi va shu query ga page bilan count ham junatiladi @GET
//
//2) get item id
//api/product
//
//bundaham querysiga id junatasizlar @GET
//
//3) categorya ga tegishli listlarni olish
//api/productbycategory/{categoryId} @GET
