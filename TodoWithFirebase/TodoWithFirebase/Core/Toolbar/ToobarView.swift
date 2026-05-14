//
//  ToobarView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 14/5/26.
//

import SwiftUI

struct ToobarView: View {
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
            
//            NavigationStack{
//                ProfileView(showSignInView: $ShowSignInView)
//            }
//            .tabItem {
//                Image(systemName: "person")
//                Text("Profile")
//            }
        }
    }
}

#Preview {
    NavigationStack{
        ToobarView(ShowSignInView: .constant(false))
    }
}
