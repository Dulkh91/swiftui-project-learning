//
//  ProductCellViewBuilder.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 15/5/26.
//

import SwiftUI

struct ProductCellViewBuilder: View {
    //MARK: - Property
    let productId: String
    @State private var product: Product? = nil
    
    //MARK: - body
    var body: some View {
        ZStack{
            if let product {
                ProductCellView(product: product)
            }
        }
        .task {
            self.product = try? await ProductManager.shared.getProduct(productId: productId)
        }
    }
}

#Preview {
    ProductCellViewBuilder(productId: "1")
}
