//
//  DetailProduct.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 10/07/23.
//

import SwiftUI
import SDWebImageSwiftUI
struct DetailProduct: View {
    
    @StateObject var viewModel = DetailProductViewModel()
    
    let id: Int
    @State private var currentPage = 0
    let newData:[Photos] = []
    
    let ima = ["keybord","keybord","keybord","keybord"]
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 10){
                    TabView(selection: $currentPage) {
                        ForEach(viewModel.data.data.photos, id: \.self) { index in
                            let url = "https://dev.mobio.uz/storage/\(index.id)/\(index.file_name)"
                            WebImage(url:(URL(string:url)))
                                .resizable()
                                .scaledToFill()
                                .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    
                    .frame(height: 300)
                Text(viewModel.data.data.name)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                VStack{
                    
                    HStack{
                        Text("Расходы:")
                            .font(.custom("Avenir Next", size: 12))
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                        Text("\(viewModel.data.data.price) сум")
                            .font(.custom("Avenir Next", size: 12))
                    }
                    
                    HStack{
                        Text("Предыдущая цена :")
                            .font(.custom("Avenir Next", size: 12))
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                        Text("\(viewModel.data.data.old_price) сум")
                            .font(.custom("Avenir Next", size: 12))
                    }
                    
                    HStack{
                        Text("Процент:")
                            .font(.custom("Avenir Next", size: 12))
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                        Text("11,76 %")
                            .font(.custom("Avenir Next", size: 12))
                    }
                    
                    HStack{
                        Text("Description:")
                            .font(.custom("Avenir Next", size: 16))
                            .foregroundColor(.gray)
                            .bold()
                        Spacer()
                                                
                    }
                    Text(viewModel.data.data.description ?? "no description")
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
        }
        .navigationTitle(viewModel.data.data.name)
        .onAppear {
            viewModel.getItem(id: self.id)
        }
    }
}

struct DetailProduct_Previews: PreviewProvider {
    static var previews: some View {
        DetailProduct(id: 0)
    }
}


struct ImageSlider: View {
    @State var images:[Photos]
    
    var body: some View {
        
        TabView {
            ForEach(images, id: \.id) { item in
                let url = "https://dev.mobio.uz/storage/\(item.id)/\(item.file_name)"
                WebImage(url: URL(string: url))
                    .resizable()
                    .scaledToFill()
            }
        }
        .tabViewStyle(PageTabViewStyle())
    }
}
