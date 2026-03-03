//
//  NavigationBarDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct NavigationBarDetailView: View {
    //MARK: - PROPERTY
    @EnvironmentObject var shop: Shop
    
    //MARK: - BODY
    var body: some View {
        HStack {
            Button {
                withAnimation(.easeInOut) {
                    feetback.impactOccurred()
                    shop.selectedProduct = nil
                    shop.showingProduct = false
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
                
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Image(systemName: "cart")
                    .font(.title)
                    .foregroundColor(.white)
            }

        }//: Hstack
    }
}

//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    NavigationBarDetailView()
        .environmentObject(Shop())
        .padding()
        .background(Color.gray)
}
