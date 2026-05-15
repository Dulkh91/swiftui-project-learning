//
//  ToobarView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 14/5/26.
//

import SwiftUI

struct TabbarView: View {
    @Binding var ShowSignInView:Bool
    var body: some View {
        
        TabView {
            
            NavigationStack{
                ProductView()
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Product")
            }
            
            NavigationStack{
                FavoriteView()
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Favorites")
            }
            
            NavigationStack{
                ProfileView(showSignInView: $ShowSignInView)
            }
            .tabItem {
                Image(systemName: "person")
                Text("Profile")
            }
        }// - Tabview
    }
}

#Preview {
    NavigationStack{
        TabbarView(ShowSignInView: .constant(false))
    }
}
