//
//  FeaturedTabView.swift
//  Touch Down
//
//  Created by Ros Dul on 24/2/26.
//

import SwiftUI

struct FeaturedTabView: View {
    var body: some View {
        TabView{
            ForEach(players){player in
                FeaturedItemView(player: player)
                    .padding(.top,10)
                    .padding(.horizontal, 15)
                    
            }
        }//: TABVIEW
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 250)
    }
}

#Preview {
    FeaturedTabView()
        .background(Color.gray)
}
