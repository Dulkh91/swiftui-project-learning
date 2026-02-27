//
//  HeaderDetailView.swift
//  Touch Down
//
//  Created by Ros Dul on 26/2/26.
//

import SwiftUI

struct HeaderDetailView: View {
    //MARK: - PROPERTY
    @EnvironmentObject var shop: Shop
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Protective Gear")
            
            Text(shop.selectedProduct?.name ?? sampleProducts.name)
                .font(.largeTitle)
                .fontWeight(.black)
            
        }
        .foregroundColor(.white)
    }
}

//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    HeaderDetailView()
        .environmentObject(Shop())
        .padding()
        .background(Color.gray)
        
}
