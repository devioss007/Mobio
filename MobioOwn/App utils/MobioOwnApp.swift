//
//  MobioOwnApp.swift
//  MobioOwn
//
//  Created by Zekhniddin Jumaev on 22/06/23.
//

import SwiftUI

@main
struct MobioOwnApp: App {
    var body: some Scene {
        WindowGroup {
            StarterScreen()
                .environmentObject(Profile())
        }
    }
}
