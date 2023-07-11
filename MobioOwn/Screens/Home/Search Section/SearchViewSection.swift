//
//  SearchViewSection.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 06/07/23.
//

import SwiftUI
import Lottie
import SDWebImageSwiftUI

struct SearchViewSection: View {
    @StateObject var viewModel = SearchViewModel()
    
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
                    .autocorrectionDisabled()
                    .onChange(of: text) { newValue in
                        print(newValue)
                        viewModel.search(with: newValue)
                    }
            }
            .frame(height: 38)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red, lineWidth: 1)
            )
            .padding()
            
            Spacer()
            
            if viewModel.items.isEmpty || text.isEmpty {
                LottieView(lottieFile: "search.json")
                    .frame(width: 180, height: 180)
                Text("Раздел поиска ")
                    .offset(y: -26)
                    .font(.system(size: 12))
            } else {
//                let t = [SearchModel.Data.Data.init(id: 0, name: "Airpods", price: "10000", photos: [SearchModel.Data.Photos(id: 64, file_name: "Y0CHiJ6VlmtDY0zTz6x8BxVFthduEU-metaQXBwcy1jb3VudGVyLXN0cmlrZS1pY29uLnBuZw==-.png")])]
                GeometryReader { geometry in
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(viewModel.items, id: \.name) { item in
                                NavigationLink {
                                    DetailProduct(id: item.id)
                                } label: {
                                    MainProductsCard2(name: item.name,
                                                      price: item.price,
                                                      photoURL: "https://dev.mobio.uz/storage/\(item.photos?.first?.id ?? 0)/\(item.photos?.first?.file_name ?? "")",
                                                      width: geometry.size.width / 2 - 10,
                                                      height: 190)
                                    .offset(y: 10)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            
            Spacer()
        }
        
    }
}


struct MainProductsCard2: View {
    
    let name: String
    let price: String
    let photoURL: String
    
    var width: CGFloat = 140.0
    var height: CGFloat = 170.0
    
    var body: some View {
        VStack {
            ZStack {
                WebImage(url: URL(string: photoURL))
                    .resizable()
                    .scaledToFill()
                    .minimumScaleFactor(0.1)
                    .frame(width: 130, height: 80)
                    .padding(.top, 13)
                
                VStack {
                    HStack(alignment: .top) {
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
            .frame(width: width)
            .background(Color.white)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("\(price) сум")
                            .font(.system(size: 14))
                            .foregroundColor(Color.black)
                    }
                    .bold()
                    .padding(.top, 8)
                    Spacer()
                }
                
                Text(name)
                    .font(.system(size: 12))
                    .padding(.bottom, 10)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
            }
            .padding(.horizontal, 10)
            .background(Color.white)
            
        }
        .frame(width: width, height: height)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
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
