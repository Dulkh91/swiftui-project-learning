//
//  TodoDemoApp.swift
//  TodoDemo
//
//  Created by Ros Dul on 28/2/26.
//

import SwiftUI
internal import CoreData

@main
struct TodoDemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                //.preferredColorScheme(.dark)
        }
    }
}
