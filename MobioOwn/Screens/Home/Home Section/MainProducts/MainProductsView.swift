//
//  MainProductsView.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 04/07/23.
//

import SwiftUI

struct MainProductsView: View {
    
    @StateObject var viewModel = MainProductsViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.data.data, id: \.title) { item in
                // MARK: - Header
                VStack {
                    HStack {
                        Text(item.title)
                            .font(.system(size: 12))
                        
                        Spacer()
                        
                        NavigationLink("Barchasini ko'rish >") {
                            Text(item.title)
                        }
                        .foregroundColor(.red)
                        .font(.system(size: 10))
                    }
                    .bold()
                    .padding(.horizontal)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0..<item.products.count, id: \.self) { index in
                            let url = item.products[index].photo
                            MainProductsCard(name: item.products[index].productsss.first!.name,
                                             old_price: item.products[index].productsss.first!.old_price,
                                             price: item.products[index].productsss.first!.price,
                                             rate: viewModel.calculateRate(item.products[index].rate), photoURL: "https://dev.mobio.uz/storage/\(url.id)/\(url.file_name)")
                        }
                    }
                    .frame(height: 180)
                }
            }
        }.onAppear {
            viewModel.getItems()
        }
    }
}

struct MainProductsView_Previews: PreviewProvider {
    static var previews: some View {
        MainProductsView()
    }
}
