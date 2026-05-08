//
//  ProductCellView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 8/5/26.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product
    var body: some View {
        HStack(alignment: .top){
            AsyncImage(url: URL(string: product.thumbnail ?? "")){ image in
                image
                    .resizable()
                    .frame(width: 75,height: 75)
                    .cornerRadius(10)
            }placeholder: {
                ProgressView()
            }
            .frame(width: 75,height: 75)
            .shadow(color: Color.black.opacity(0.3), radius: 4, x: 0, y: 2)
            
            VStack(alignment: .leading, spacing: 4){
                Text(product.title ?? "n/a" )
                    .font(.headline)
                    .foregroundColor(Color.primary)
                Text("$" + String( product.price ?? 0 ))
                Text("Rating: " + String(product.rating ?? 0))
                Text("Category: " + String(product.category ?? "n/a"))
                Text("Brand: " + String(product.brand ?? "n/a"))
            }//VSTACK
            .font(.callout)
            .foregroundColor(.secondary)
        }// HSTACK
    }
}

#Preview {
    ProductCellView(product: Product(id: 1, title: "test", description: "teat", price: 45, discountPercentage: 10, rating: 1.2, stock: 23, brand: "abg", category: "test", thumbnail: "fdkfjdkf", images: []))
}
