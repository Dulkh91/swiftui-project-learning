//
//  ProductView.swift
//  TodoWithFirebase
//
//  Created by Ros Dul on 8/5/26.
//

import SwiftUI
internal import Combine

@MainActor
final class ProductViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    
    func getAllProducts()async throws{
        self.products = try await ProductManager.share.getAllProducts()
    }

}

struct ProductView: View {
    @StateObject private var viewModel = ProductViewModel()
    var body: some View {
        List{
            ForEach(viewModel.products) { product in
                ProductCellView(product: product)
            }
        }
        .navigationTitle("Product")
        
        .task {
            try? await viewModel.getAllProducts()
        }
        
    }
}

#Preview {
    ProductView()
}
