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
    
    var body: some View {
        ScrollView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.data.data.photos, id: \.id) { photo in
                            let url = "https://dev.mobio.uz/storage/\(photo.id)/\(photo.file_name)"
                            WebImage(url: URL(string: url))
                                .resizable()
                                .scaledToFill()
                                .minimumScaleFactor(0.1)
                                .frame(width: 100, height: 100)
                        }

                    }
                }
                
                Text(viewModel.data.data.name)
                    .padding()
                Text(viewModel.data.data.description ?? "no description")
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
