
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var profile: Profile
    
    var body: some View {
        VStack {
//            if UserDefaults.standard.string(forKey: UserDefaultsManager.Token.access_token.rawValue) != nil || profile.isLoggedIn {
//                HomeScreen()
//            } else {
//                OpeningView()
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


