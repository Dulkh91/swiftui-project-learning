//
//  ToolbarView.swift
//  toolbarDemo
//
//  Created by Ros Dul on 14/5/26.
//

import SwiftUI

struct ToolbarView: View {
    var body: some View {
        TabView{
            NavigationStack{
                ProductView()
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Product")
            }
            
            NavigationStack{
                ProfileView()
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }
    }
}

#Preview {
    ToolbarView()
}
