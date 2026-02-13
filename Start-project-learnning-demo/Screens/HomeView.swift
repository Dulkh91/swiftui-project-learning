//
//  Home.swift
//  Start-project-learnning-demo
//
//  Created by Ros Dul on 13/2/26.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isHomeActive: Bool = false
    var body: some View {
        VStack(spacing: 20){
            Text("home".uppercased())
                .font(.largeTitle)
            Button {
                isHomeActive = true
            } label: {
                Text("Reset")
                    .font(.headline)
            }

        }
    }
}

#Preview {
    HomeView()
}
