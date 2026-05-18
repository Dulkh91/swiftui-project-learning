//
//  firebaseAuthGoogleApp.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import SwiftUI
import FirebaseCore

@main
struct firebaseAuthGoogleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
    
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

