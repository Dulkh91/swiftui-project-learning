//
//  HomeView.swift
//  firebaseAuthGoogle
//
//  Created by Ros Dul on 18/5/26.
//

import SwiftUI

struct HomeView: View {
    @Binding var showLognInScreen: Bool
    var body: some View {
        NavigationStack{
            ZStack{
                Text("Hello home page")
            }
            
            
            .toolbar {
                ToolbarItem{
                    NavigationLink(destination: SettingView(showLognInScreen: $showLognInScreen)) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            
            .navigationTitle("Home")
        }
        
        
    }
}

#Preview {
    HomeView(showLognInScreen: .constant(false))
}
