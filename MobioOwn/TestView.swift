
import SwiftUI

struct TestView: View {
    
    var body: some View {
        VStack {
            ScrollView {
                Button {
                    withAnimation(.easeInOut(duration: 0.4).delay(0.2)) {
//                        selectedMenu = .glavnoeOkno
                    }
                    withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
//                        isMenuOpen = false
                    }
                } label: {
                    HStack {
                        Image(systemName: "house.fill")
                            .padding(.leading)
                            .foregroundColor(.red)
                        Text("Главное окно")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.vertical)
                    .background(Color.pink.opacity(0.15))
                    .cornerRadius(4)
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                }

//                Button {
//                    withAnimation(.easeInOut(duration: 0.4).delay(0.2)) {
////                        selectedMenu = .departamenti
//                    }
//                    withAnimation(.easeInOut(duration: 0.8).delay(0.2)) {
////                        isMenuOpen = false
//                    }
//                } label: {
//                    Text("departamenti")
//                }

            }
            Spacer()
        }
        .frame(width: 200, height: 600)
//        .background(Color.green)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
