//
//  HomeViewSection.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 27/06/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeViewSection: View {
    
    @StateObject var viewModel = HomeViewSectionViewModel()
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                VStack {
                    // MARK: - Header
                    HStack {
                        Text("Bo'limlar")
                        Spacer()
                        NavigationLink("Barchasini ko'rish >") {
                            DetailCategoryScreen(items: viewModel.items)
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    // MARK: - Items
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 4) {
                            ForEach(0..<viewModel.items.count, id: \.self) { index in
                                VStack(alignment: .center, spacing: 6) {
                                    if viewModel.items.isLastItem(viewModel.items[index]) {
                                        VStack { }.onAppear {
                                            viewModel.getItems()
                                        }
                                        
                                        if let url = viewModel.items[index].photo_cat {
                                            WebImage(url: URL(string: "https://dev.mobio.uz/storage/\(url.id)/\(url.file_name)"))
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .cornerRadius(25)
                                        } else {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(viewModel.showProgressView ? .white : Color.gray)
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(25)
                                                ProgressView()
                                            }
                                        }
                                        
                                    } else {
                                        
                                        if let url = viewModel.items[index].photo_cat {
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
                                        
                                    }
                                    
                                    Text(viewModel.items[index].name)
                                        .multilineTextAlignment(.center)
                                        .scaledToFit()
                                        .font(.system(size: 10))
                                        .lineLimit(nil)
                                        .padding(.horizontal)
                                }
                                .frame(width: 100)
                            }
                        }
//                        .padding(.trailing, -100)
                    }
                    .frame(height: 100)
                    Spacer()
                }
                
                
                //                if viewModel.showProgressView {
                //                    ZStack {
                //                        Rectangle()
                //                            .opacity(0.3)
                //                        ProgressView()
                //                            .progressViewStyle(CircularProgressViewStyle())
                //                            .scaleEffect(2)
                //                    }
                //                }
            }
        }
        .onAppear {
            if viewModel.items.isEmpty {
                viewModel.getItems()
            }
        }
    }
}

struct HomeViewSection_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewSection()
    }
}

extension RandomAccessCollection where Self.Element: Identifiable {
    func isLastItem<Item: Identifiable>(_ item: Item) -> Bool {
        guard !isEmpty else {
            return false
        }
        
        guard let itemIndex = firstIndex(where: { AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        
        let distance = self.distance(from: itemIndex, to: endIndex)
        return distance == 1
    }
}
