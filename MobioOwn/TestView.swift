
import SwiftUI

struct TestView: View {
    
    var body: some View {
        VStack {
            GeometryReader { screen in
                HStack(spacing: 6) {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(Color.gray.opacity(0.8))
                        .font(.system(size: 48))

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Информация недоступна")
                            .foregroundColor(Color.primary)
                            .bold()
                            .font(.system(size: 14))

                        Text("Информация недоступна")
                            .foregroundColor(Color.secondary)
                            .font(.system(size: 14))

                    }
                    Spacer()
                }
                .frame(width: screen.size.width * 0.65, height: screen.size.height)
                .background(Color.green)
            }
            
//            ScrollView {
//                Button {
//                    withAnimation(.easeInOut(duration: 0.4).delay(0.2)) {
////                        selectedMenu = .glavnoeOkno
//                    }
//                    withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
////                        isMenuOpen = false
//                    }
//                } label: {
//                    HStack {
//                        Image(systemName: "house.fill")
//                            .padding(.leading)
//                            .foregroundColor(.red)
//                        Text("Главное окно")
//                            .foregroundColor(.gray)
//                        Spacer()
//                    }
//                    .padding(.vertical)
//                    .background(Color.pink.opacity(0.15))
//                    .cornerRadius(4)
//                    .padding(.horizontal, 10)
//                    .padding(.top, 10)
//                }
//
////                Button {
////                    withAnimation(.easeInOut(duration: 0.4).delay(0.2)) {
//////                        selectedMenu = .departamenti
////                    }
////                    withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
//////                        isMenuOpen = false
////                    }
////                } label: {
////                    Text("departamenti")
////                }
//
//            }
//            Spacer()
        }
//        .frame(width: 200, height: 600)
//        .background(Color.green)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
