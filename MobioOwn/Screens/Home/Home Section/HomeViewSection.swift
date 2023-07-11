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
    
    @State var scrollViewOffset: CGFloat = 0
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { proxyReader in
                ScrollView(showsIndicators: false) {
                    VStack {
                        // MARK: - Header
                        HStack {
                            Text("Bo'limlar")
                                .font(.system(size: 12))
                            
                            Spacer()
                            NavigationLink("Barchasini ko'rish >") {
                                DetailCategoryScreen(items: viewModel.items)
                            }
                            .foregroundColor(.red)
                            .font(.system(size: 10))
                        }
                        .bold()
                        .padding(.horizontal)
                        // MARK: - Items
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: -25) {
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
                            .offset(x: -14)
                            //                        .padding(.trailing, -100)
                        }
                        //                    .background(Color.red)
                        //                    .frame(height: 80)
                        Spacer()
                        
                        // MARK: - Sub Views here
                        
                        SliderView()
                        MainProductsView()
                        ChildProductsView()
                    }
                    .id("Scroll_To_Top")
                    
                    .overlay(
                        GeometryReader { proxy -> Color in
                            DispatchQueue.main.async {
                                if startOffset == 0 {
                                    self.startOffset = proxy.frame(in: .global).minY
                                }
                                let offset = proxy.frame(in: .global).minY
                                self.scrollViewOffset = offset - startOffset
                            }
                            return Color.clear
                        }
                        .frame(width: 0, height: 0)
                        ,alignment: .top
                    )//: Overlay GemotryReader

                }
                .overlay(
                    Button(action: {
                        withAnimation(.spring()) {
                            proxyReader.scrollTo("Scroll_To_Top", anchor: .top)
                        }
                    }, label: {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.09), radius: 5, x: 5, y: 5)
                    })
                    .padding(.trailing)
                    .padding(.bottom,getSafeArea().bottom == 0 ? 12 : 0)
                    .opacity(-scrollViewOffset > 350 ? 1 : 0)
                    .animation(.easeInOut)
                    , alignment: .bottomTrailing
                )//: Overlay Button

                
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
        .refreshable {
            print("refresh action")
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

extension View {
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
