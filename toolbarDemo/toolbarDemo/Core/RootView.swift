//
//  ContentView.swift
//  toolbarDemo
//
//  Created by Ros Dul on 14/5/26.
//

import SwiftUI

struct RootView: View {
    @State private var user = true
    var body: some View {
        ZStack{
            if(user){
                ToolbarView()
            }
        }
    }
}

#Preview {
    RootView()
}
