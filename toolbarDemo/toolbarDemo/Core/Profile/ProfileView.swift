//
//  ProfileView.swift
//  toolbarDemo
//
//  Created by Ros Dul on 14/5/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text("Hello I am Ros Dul")
            Text("I am junior swiftUI developer ")
            
        }// - vstack
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow)
        
        .navigationTitle("Profile")
        
    }
}

#Preview {
    NavigationStack{
        ProfileView()
    }
}
