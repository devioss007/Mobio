//
//  ChildProductsView.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 05/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChildProductsView: View {
    
    @StateObject var viewModel = ChildProductsViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.data.data, id: \.title) { item in
                
                VStack {
                    // MARK: - Header
                    VStack {
                        HStack {
                            Text(item.title)
                                .font(.system(size: 12))
                            
                            Spacer()
                            
                            NavigationLink("Barchasini ko'rish >") {
                                //                        Text("Наушники")
                                CategoryDetailView(title: item.title, id: item.id)
                            }
                            .foregroundColor(.red)
                            .font(.system(size: 10))
                        }
                        .bold()
                    }
                    .padding(.bottom, 6)
                    
                    ForEach(0..<item.products.count, id: \.self) { index in
                        if !item.products[index].productsss.isEmpty {
                            VStack {
                                
                                HStack {
                                    Spacer()
                                }
                                .frame(height: 1)
                                .background(Color.gray.opacity(0.6))
                                .padding(.vertical, 4)
                                NavigationLink {
                                    DetailProduct(id: item.products[index].productsss.first!.id)
                                } label: {
                                    HStack(spacing: 10) {
                                        WebImage(url: URL(string: "https://dev.mobio.uz/storage/\(item.products[index].photo!.id)/\(item.products[index].photo!.file_name)"))
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 60, height: 60)
                                            .cornerRadius(8)

                                        
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text(item.products[index].productsss.first!.name)
                                                .font(.system(size: 12.5))
                                                .multilineTextAlignment(.leading)
                                                .foregroundColor(Color.black)
                                            
                                            HStack(spacing: 12) {
                                                Text(String(format: "%.0f", Double(item.products[index].productsss.first!.price)!) + " сум")
                                                    .foregroundColor(.pink)
                                                
                                                HStack(spacing: 4) {
                                                    Image(systemName: "star.fill")
                                                        .foregroundColor(.yellow)
                                                    Text(String(format: "%.2f", viewModel.calculateRate(item.products[index].rate)))
                                                }
                                            }
                                            .font(.system(size: 11))
                                            
                                            Text(String(item.products[index].rate.count) + " Комментарий")
                                                .font(.system(size: 11))
                                                .foregroundColor(Color.black)
                                            
                                        }
                                        Spacer()
                                    }
                                    .padding(.vertical, 4)
                                }

                                
                            }
                            
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 4)
                .padding(.horizontal)
            }
        }
        .onAppear {
            viewModel.getItems()
        }
    }
}


struct ChildProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ChildProductsView()
    }
}
