//
//  ProductView.swift
//  Touch Down
//
//  Created by Ros Dul on 25/2/26.
//

import SwiftUI

struct ProductView: View {
    //MARK: - PROPERTY
    @State var product: ProductModel
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // PHOTO
            ZStack{
                Image(product.image)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }//: ZSTACK
            .background(Color(red: product.red,
                              green: product.green,
                              blue: product.blue))
            .cornerRadius(12)
            
            // NAME
                Text(product.name)
                .font(.title3)
                .fontWeight(.black)
            
            
            // PRICE
            Text(product.formattedPrice)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
        }//: VSTACK
    }
}

//MARK: - PREVIEW
#Preview(traits: .sizeThatFitsLayout) {
    ProductView(product: products[0])
        .frame(width: 300, height: 400)
    
}
