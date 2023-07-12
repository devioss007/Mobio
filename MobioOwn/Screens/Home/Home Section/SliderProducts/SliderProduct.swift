//
//  SliderProduct.swift
//  MobioOwn
//
//  Created by Oyatullo Koraboev on 11/07/23.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI
struct SliderModel:Identifiable{
    let id = UUID()
    let price:String
    let image:String
}

enum DragState {
    case inactive
    case dragging(translation: CGFloat)
}

struct SliderView: View {
    @GestureState private var dragState = DragState.inactive
    @State private var currentPage = 0
    @State var index: Int = 0
    @State var timer = Timer.publish(every: 2.0, on: RunLoop.main, in: RunLoop.Mode.common).autoconnect()
    
    let ntManager = NetworkManager()
    @State var db:[HomeScreenItems]?
    
    var body: some View {
        ZStack {
            VStack {
                HStack{
                    Text("Департамент")
                        .font(.system(size: 12))
                        .bold()
                                                
                    Spacer()
                    NavigationLink("Увидеть все >") {
                        CategoryDetailView(title:"Category" ,id: 23)
                    }
                    .foregroundColor(.red)
                    .font(.system(size: 10))
                    
                }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                VStack{
                    if let newData = db{
                        ForEach(newData.indices){ i in
                            if index == i {
                                NavigationLink {
                                    DetailProduct(id:8)
                                }label:{
                                    SliderCardView(sliderModel:newData[i])
                                        
                                }.transition(.cubeRotation)
                                
                            }
                        }
                        
                        PageControl(numberOfPages: 6, currentPage: $currentPage)
                    }
                }
            }
        }
        .onAppear(perform: {
            ntManager.fethcProducts { result in
                switch result {
                case .success(let product):
                    DispatchQueue.main.async {
                        db = product.category.data
                        if let db = db {
                            print("Coming Data \(db)")
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }
        })
        .gesture(
                DragGesture()
                    .updating($dragState) { value, state, _ in
                        state = .dragging(translation: value.translation.width)
                    }
                    .onEnded { value in
                        if let newDB = db {
                            if value.translation.width < -100 {
                                // Swiped left, go to the next slide
                                index = (index + 1) % newDB.count
                            } else if value.translation.width > 100 {
                                // Swiped right, go to the previous slide
                                index = (index + newDB.count - 1) % newDB.count
                            }
                        }
                    }
            )
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .onReceive(timer) { _ in
            withAnimation(.easeInOut(duration: 1.3)) {
                if let newDb = db {
                    index = (index + 1) % newDb.count
                }
                currentPage = index
            }
        }
    }
}


struct SliderCardView: View {
    var sliderModel: HomeScreenItems
    
    var body: some View {
        HStack {
            
            VStack{
                Text(sliderModel.name)
                    .foregroundColor(.white)
                    .font(.title3)
                    .bold()
                Button {
                    print("Купи сейчас")
                } label: {
                    Text("Купи сейчас")
                        .foregroundColor(.pink)
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(.white)
                .cornerRadius(10)

            }.frame(maxWidth: .infinity,maxHeight:.infinity)
            .background(.pink)
            Spacer()
            WebImage(url: URL(string: "https://dev.mobio.uz/storage/\(sliderModel.photo_cat?.id ?? 64)/\(sliderModel.photo_cat?.file_name ?? "Y0CHiJ6VlmtDY0zTz6x8BxVFthduEU-metaQXBwcy1jb3VudGVyLXN0cmlrZS1pY29uLnBuZw==-.png")"))
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var activeColor: Color = .pink
    var inactiveColor: Color = .white
    
    var body: some View {
            HStack(spacing: 6) {
                ForEach(0..<numberOfPages, id: \.self) { page in
                    ZStack {
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(currentPage == page ? activeColor : inactiveColor)
                        
                        Circle()
                            .stroke(activeColor, lineWidth: 2)
                            .frame(width: 8, height: 8)
//                            .opacity(currentPage == page ? 1 : 0)
                    }
                }
            }
        }
}


struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView()
    }
}


