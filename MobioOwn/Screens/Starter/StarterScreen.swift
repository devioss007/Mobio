//
//  StarterScreen.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 23/06/23.
//

import SwiftUI

struct StarterScreen: View {
    @EnvironmentObject var profile: Profile

    var body: some View {
        VStack {
            if profile.isUserLoggedIn {
                HomeScreen()
            } else {
                AuthorizationScreen()
            }
        }
    }
}

struct StarterScreen_Previews: PreviewProvider {
    static var previews: some View {
        StarterScreen()
    }
}
