
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
                
                // MARK: - Header
                VStack {
                    HStack {
                        Text("Departament")
                            .font(.system(size: 12))
                        
                        Spacer()
                        
                        NavigationLink("Barchasini ko'rish >") {
                            //                        Text("Наушники")
                        }
                        .foregroundColor(.red)
                        .font(.system(size: 10))
                    }
                    .bold()
                }
                .padding(.horizontal)
                
                VStack{
                    if let newData = db{
                        ForEach(newData.indices){ i in
                            if index == i {
                                SliderCardView(sliderModel:newData[i])
                                    .transition(.cubeRotation)
                            }
                        }
                        
                        PageControl(numberOfPages: newData.count, currentPage: $currentPage)
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



////
////Product(category: MobioOwn.Category(data:
//[
//MobioOwn.Datum(id: 23, name: "Test", slug: "test", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 22, name: "Портативные аккумляторы", slug: "portativnye-akkumlyatory", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 21, name: "Аксессуары для телефонов", slug: "aksessuary-dlya-telefonov", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 20, name: "Портативные жесткие диски", slug: "portativnye-zestkie-diski", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 19, name: "Точки доступа и усилители сигнала", slug: "tocki-dostupa-i-usiliteli-signala", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 18, name: "Сетевое оборудование", slug: "setevoe-oborudovanie", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 17, name: "Портативные колонки", slug: "portativnye-kolonki", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 16, name: "Акустика", slug: "akustika", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 15, name: "Браслеты и умные часы", slug: "braslety-i-umnye-casy", uzname: nil, photo: nil),
// MobioOwn.Datum(id: 14, name: "Кнопочные телефоны", slug: "knopocnye-telefony", uzname: nil, photo: nil)]))


//
//  CustomTransition.swift
//  MobioOwn
//
//  Created by Oyatullo Koraboev on 11/07/23.
//

import SwiftUI

struct CubeRotationModifier: AnimatableModifier {
    enum SlideDirection {
        case enter
        case exit
    }
    
    var pct: Double
    var direction: SlideDirection
    
    var animatableData: Double {
        get { pct }
        set { pct = newValue }
    }
    

    func calcRotation() -> Double {
        if direction == .enter {
            return 90 - (pct * 90)
        } else {
            return -1 * (pct * 90)
        }
    }
    
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .rotation3DEffect(
                    Angle(degrees: calcRotation()),
                    axis: (x: 0.0, y: 1.0, z: 0.0),
                    anchor: direction == .enter ? .leading : .trailing,
                    anchorZ: 0,
                    perspective: 0.1
                ).transformEffect(.init(translationX: calcTranslation(geo: geo), y: 0))
        }
    }

    func calcTranslation(geo: GeometryProxy) -> CGFloat {
        if direction == .enter {
            return geo.size.width - (CGFloat(pct) * geo.size.width)
        } else {
            return -1 * (CGFloat(pct) * geo.size.width)
        }
    }
}


extension AnyTransition {
    static var cubeRotation: AnyTransition {
        get {
            AnyTransition.asymmetric(
                insertion: AnyTransition.modifier(active: CubeRotationModifier(pct: 0, direction: .enter), identity: CubeRotationModifier(pct: 1, direction: .enter)),
                removal: AnyTransition.modifier(active: CubeRotationModifier(pct: 1, direction: .exit), identity: CubeRotationModifier(pct: 0, direction: .exit)))
        }
    }
}
