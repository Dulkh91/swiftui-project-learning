//
//  AddToCartDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 27/2/26.
//

import SwiftUI

struct AddToCartDetailView: View {
    var body: some View {
            
            Button {
                
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
                    red: sampleProducts.red,
                    green: sampleProducts.green,
                    blue: sampleProducts.blue
                )
            )
            .clipShape(Capsule())
            

    }
}

#Preview(traits: .sizeThatFitsLayout) {
    AddToCartDetailView()
        .padding()
}
