//
//  CategoryDetailView.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 10/07/23.
//

import SwiftUI

struct CategoryDetailView: View {
    let title: String
    let id: Int
    
    @StateObject var viewModel = CategoryDetailViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(viewModel.data.data.data, id: \.photo.id) { item in
                        NavigationLink {
                            DetailProduct(id: item.productss.id)
                        } label: {
                            MainProductsCard(name: item.productss.name,
                                             old_price: item.productss.old_price,
                                             price: item.productss.price,
                                             rate: viewModel.calculateRate(item.rate),
                                             photoURL: "https://dev.mobio.uz/storage/\(item.photo.id)/\(item.photo.file_name)",
                                             width: geometry.size.width / 2 - 10, height: 190)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .navigationTitle(title)
        .onAppear {
            viewModel.getItems(id: id)
        }
    }
}

//struct CategoryDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryDetailView()
//    }
//}
