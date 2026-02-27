//
//  AddToCartDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 27/2/26.
//

import SwiftUI

struct AddToCartDetailView: View {
    @EnvironmentObject var shop: Shop
    var body: some View {
            
            Button {
                feetback.impactOccurred()
            } label: {
                Spacer()
                
                Text("Add to cart")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
    
                Spacer()
            }
            .padding()
            .background(
                Color(
                    red: shop.selectedProduct?.red ?? sampleProducts.red,
                    green: shop.selectedProduct?.green ?? sampleProducts.green,
                    blue: shop.selectedProduct?.blue ?? sampleProducts.blue
                )
            )
            .clipShape(Capsule())
            

    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AddToCartDetailView()
        .environmentObject(Shop())
        .padding()
}
