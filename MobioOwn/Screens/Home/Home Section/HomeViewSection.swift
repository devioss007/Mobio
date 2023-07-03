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
                    HStack {
                        Text("Bo'limlar")
                        Spacer()
                        NavigationLink("Barchasini ko'rish >") {
                            DetailCategory(items: viewModel.items)
                        }
                    }
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 4) {
                            ForEach(0..<viewModel.items.count, id: \.self) { index in
                                VStack(alignment: .center, spacing: 6) {
                                    if viewModel.items.isLastItem(viewModel.items[index]) {
                                        VStack { }.onAppear {
                                            viewModel.getItems()
                                        }
                                    }
                                    WebImage(url: URL(string: "https://dev.mobio.uz/storage/64/Y0CHiJ6VlmtDY0zTz6x8BxVFthduEU-metaQXBwcy1jb3VudGVyLXN0cmlrZS1pY29uLnBuZw==-.png"))
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(30)
                                        
                                    
                                    Text(viewModel.items[index].name)
                                        .multilineTextAlignment(.center)
                                        .scaledToFit()
                                        .font(.system(size: 12))
                                        .lineLimit(nil)
                                        .padding(.horizontal)
                                }
                                .frame(width: 100)
                            }
                        }
                        .padding()
                    }
                    .frame(height: 100)
                    Spacer()
                }
                
                
                if viewModel.showProgressView {
                    ZStack {
                        Rectangle()
                            .opacity(0.3)
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(2)
                    }
                }
            }
        }
        .onAppear {
            viewModel.getItems()
        }
    }
}

struct HomeViewSection_Previews: PreviewProvider {
    static var previews: some View {
//        DetailCategory()
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


struct DetailCategory: View {
    
    let items: [HomeScreenItems]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                ForEach(items, id: \.self) { item in
                    VStack {
                        Circle()
                            .frame(width: 60, height: 60)
                        Text(item.name)
                            .multilineTextAlignment(.center)
                            .scaledToFit()
                            .font(.system(size: 12))
                            .lineLimit(nil)
                            .padding(.horizontal)
                    }
                    
                }
            }
            .padding()
        }
    }}
