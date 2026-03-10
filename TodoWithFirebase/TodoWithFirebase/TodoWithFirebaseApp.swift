//
//  TodoWithFirebaseApp.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 6/3/26.
//

import SwiftUI
import Firebase



@main
struct TodoWithFirebaseApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                //AuthenticationView()
                RootView()
            }
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
