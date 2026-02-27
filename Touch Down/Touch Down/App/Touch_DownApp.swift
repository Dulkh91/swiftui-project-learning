//
//  Touch_DownApp.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import SwiftUI

@main
struct Touch_DownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Shop())
        }
    }
}
